import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';
import 'package:projectresearch/widgets/textFormField.dart';

class TypingQuestion extends StatefulWidget {
  const TypingQuestion({super.key});

  @override
  State<TypingQuestion> createState() => _TypingQuestionState();
}

class _TypingQuestionState extends State<TypingQuestion> {
  TextEditingController questions = TextEditingController();
  TextEditingController correctAnswer = TextEditingController();
  TextEditingController referindex = TextEditingController();
  CollectionReference questionData =
      FirebaseFirestore.instance.collection("structure5");
  File? _image;
  String fileName = '';
  bool isLoading = false;

  Future getImage() async {
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

  Future imageSave() async {
    if (_image != null) {
      String extension = _image.toString().split('.').last;
      String extensionRepair = extension.replaceAll("'", "");
      fileName = '${DateTime.now().millisecondsSinceEpoch}.$extensionRepair';

      File compressedImage = await _compressImage(_image!);
      await FirebaseStorage.instance.ref(fileName).putFile(compressedImage);
    }
  }

  Future dataAdd() async {
    await questionData.add({
      'questions': questions.text,
      'answer': correctAnswer.text,
      'referindex': int.parse(referindex.text),
      'image': fileName
    });
    setState(() {
      questions.clear();
      correctAnswer.clear();
      referindex.clear();
      _image = null;
      fileName = '';
    });
  }

  void handleSave() async {
    if (questions.text.isEmpty ||
        correctAnswer.text.isEmpty ||
        referindex.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await imageSave();
      await dataAdd();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            pictureBox(),
            TextFormFields(text: "Questions", controller: questions),
            TextFormFields(text: "Answer", controller: correctAnswer),
            TextFormFields(text: "ReferIndex", controller: referindex),
            elevatedButtons(
              text: "Save",
              onclick: handleSave,
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
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
