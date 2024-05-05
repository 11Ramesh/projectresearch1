import 'package:flutter/material.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:projectresearch/widgets/textFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future dataAdd() async {
    questionData.add({
      'referindex': int.parse(referindex.text),
      'note': note.text,
      'topic': topic.text,
      'youtube': youtube.text,
      'subTopic': subTopic.text
    });
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
            TextFormFields(text: "referindex", controller: referindex),
            TextFormFields(text: "topic", controller: topic),
            TextFormFields(text: "subTopic", controller: subTopic),
            TextFormFields(text: "note", controller: note),
            TextFormFields(text: "youtube", controller: youtube),
            elevatedButtons(
              text: "Save",
              onclick: () {
                dataAdd();
                referindex.clear();
                topic.clear();
                subTopic.clear();
                note.clear();
                youtube.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
