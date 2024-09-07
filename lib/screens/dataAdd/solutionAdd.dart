import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:projectresearch/widgets/textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as img;

class SolutionAdd extends StatefulWidget {
  const SolutionAdd({super.key});

  @override
  State<SolutionAdd> createState() => _SolutionAddState();
}

class _SolutionAddState extends State<SolutionAdd> {
  TextEditingController note = TextEditingController();
  TextEditingController referindex = TextEditingController();
  TextEditingController subTopic = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController youtube = TextEditingController();
  CollectionReference questionData =
      FirebaseFirestore.instance.collection("solution");
  File? _image;
  String fileName = '';

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future dataAdd() async {
    try {
      questionData.add({
        'referindex': int.parse(referindex.text),
        'note': note.text,
        'topic': topic.text,
        'youtube': youtube.text,
        'subTopic': subTopic.text,
        'image': fileName,
      });

      setState(() {
        referindex.clear();
        topic.clear();
        subTopic.clear();
        note.clear();
        youtube.clear();
        _image = null;
        fileName = '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Solution added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> imageSave() async {
    if (_image != null) {
      try {
        String extension = _image.toString().split('.').last;
        String extensionRepair = extension.replaceAll("'", "");
        fileName = '${DateTime.now().millisecondsSinceEpoch}.$extensionRepair';

        File compressedImage = await _compressImage(_image!);
        await FirebaseStorage.instance
            .ref('solution/$fileName')
            .putFile(compressedImage);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
        throw e; // Re-throw to prevent proceeding with dataAdd
      }
    }
  }

  Future<File> _compressImage(File file) async {
    Uint8List imageBytes = await file.readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);

    img.Image resizedImage = img.copyResize(originalImage!, width: 800);

    Uint8List compressedBytes =
        Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

    File compressedFile =
        File('${file.parent.path}/compressed_${file.uri.pathSegments.last}');
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Texts(
              text: "solution Add",
              fontSize: 20,
            ),
            pictureBox(),
            TextFormFields(text: "referindex", controller: referindex),
            TextFormFields(text: "topic", controller: topic),
            TextFormFields(text: "subTopic", controller: subTopic),
            TextFormFields(text: "note", controller: note),
            TextFormFields(text: "youtube", controller: youtube),
            elevatedButtons(
              text: "Save",
              onclick: () async{
                try {
                  await imageSave();
                  await dataAdd();
                } catch (e) {
                  print('An error occurred: $e');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget pictureBox() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(8.0),
        child: _image == null
            ? Icon(Icons.add_a_photo, size: 100)
            : Image.file(
                _image!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
