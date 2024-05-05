import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';

import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/data.dart';
import 'package:projectresearch/screens/question/question.dart';
import 'package:projectresearch/widgets/InstructionListView.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Instruction extends StatefulWidget {
  const Instruction({super.key});

  @override
  State<Instruction> createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  @override
  Widget build(BuildContext context) {
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return Scaffold(
      appBar: MainAppbar(),
      body: Scaffold(
        appBar: AppBar(
          title: const Text("Instruction"),
          centerTitle: true,
        ),
        body: InstructionLists(),
      ),
      floatingActionButton: FloatingActionButtons(
          onclick: () {
            firebaseblock.add(addQuestionEvent());

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Question()));
          },
          text: "මිලග"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
