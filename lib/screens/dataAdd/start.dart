import 'package:flutter/material.dart';
import 'package:projectresearch/screens/dataAdd/questionAdd.dart';
import 'package:projectresearch/screens/dataAdd/solutionAdd.dart';
import 'package:projectresearch/screens/dataAdd/typingQuestionAdd.dart';
import 'package:projectresearch/screens/question/question.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          elevatedButtons(
            text: "MCQ Question",
            onclick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuestionADD()));
            },
          ),
          elevatedButtons(
            text: "Structure Question",
            onclick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TypingQuestion()));
            },
          ),
          elevatedButtons(
            text: "Solution",
            onclick: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SolutionAdd()));
            },
          )
        ],
      ),
    );
  }
}
