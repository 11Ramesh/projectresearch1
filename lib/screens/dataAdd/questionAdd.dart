import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:projectresearch/widgets/textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;

class QuestionADD extends StatefulWidget {
  const QuestionADD({super.key});

  @override
  State<QuestionADD> createState() => _QuestionADDState();
}

class _QuestionADDState extends State<QuestionADD> {
  TextEditingController questions = TextEditingController();
  TextEditingController correctAnswerIndex = TextEditingController();
  TextEditingController referindex = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController answer4 = TextEditingController();
  CollectionReference questionData = FirebaseFirestore.instance.collection("mcq1");
  File? _image;
  String fileName = '';

  Future<void> getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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

    Uint8List compressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

    File compressedFile = File('${file.parent.path}/compressed_${file.uri.pathSegments.last}');
    await compressedFile.writeAsBytes(compressedBytes);

    return compressedFile;
  }

  Future<void> dataAdd() async {
    try {
      await questionData.add({
        'questions': questions.text,
        'correctAnswerIndex': int.parse(correctAnswerIndex.text),
        'referindex': int.parse(referindex.text),
        '1': answer1.text,
        '2': answer2.text,
        '3': answer3.text,
        '4': answer4.text,
        'image': fileName,
      });

      setState(() {
        questions.clear();
        correctAnswerIndex.clear();
        referindex.clear();
        answer1.clear();
        answer2.clear();
        answer3.clear();
        answer4.clear();
        _image = null;
        fileName = '';  // Clear fileName after data is added
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Question added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add question: $e')),
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
        await FirebaseStorage.instance.ref(fileName).putFile(compressedImage);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
        throw e; // Re-throw to prevent proceeding with dataAdd
      }
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
            Texts(text: "Question Add", fontSize: 20),
            TextFormFields(text: "questions", controller: questions),
            TextFormFields(text: "correctAnswerIndex", controller: correctAnswerIndex),
            TextFormFields(text: "referindex", controller: referindex),
            TextFormFields(text: "answer1", controller: answer1),
            TextFormFields(text: "answer2", controller: answer2),
            TextFormFields(text: "answer3", controller: answer3),
            TextFormFields(text: "answer4", controller: answer4),
            elevatedButtons(
              text: "Save",
              onclick: () async {
                try {
                  await imageSave();
                  await dataAdd();
                } catch (e) {
                  print('An error occurred: $e');
                }
              },
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
