import 'package:flutter/material.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:projectresearch/widgets/textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  CollectionReference questionData =
      FirebaseFirestore.instance.collection("mcq1");

  Future dataAdd() async {
    questionData.add({
      'questions': questions.text,
      'correctAnswerIndex': int.parse(correctAnswerIndex.text),
      'referindex': int.parse(referindex.text),
      '1': answer1.text,
      '2': answer2.text,
      '3': answer3.text,
      '4': answer4.text
    });
    questions.clear();
    correctAnswerIndex.clear();
    referindex.clear();
    answer1.clear();
    answer2.clear();
    answer3.clear();
    answer4.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Texts(
              text: "Question Add",
              fontSize: 20,
            ),
            TextFormFields(text: "questions", controller: questions),
            TextFormFields(
                text: "correctAnswerIndex", controller: correctAnswerIndex),
            TextFormFields(text: "referindex", controller: referindex),
            TextFormFields(text: "answer1", controller: answer1),
            TextFormFields(text: "answer2", controller: answer2),
            TextFormFields(text: "answer3", controller: answer3),
            TextFormFields(text: "answer4", controller: answer4),
            elevatedButtons(
              text: "Save",
              onclick: () {
                dataAdd();
              },
            )
          ],
        ),
      ),
    );
  }
}
