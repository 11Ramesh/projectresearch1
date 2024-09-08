import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/screens/Instructions.dart';
import 'package:projectresearch/screens/dataAdd/start.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/Topiclistview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            "මාතෘකා",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TopicLists(),
        ),
      ),
      floatingActionButton:
          // Row(
          //   children: [
          //     FloatingActionButtons(
          //         onclick: () {
          //           Navigator.push(
          //               context, MaterialPageRoute(builder: (context) => Start()));
          //         },
          //         text: "ADD"),
          //     FloatingActionButtons(
          //         onclick: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => Instruction()));
          //         },
          //         text: "මිලග"),
          //   ],
          // ),
          FloatingActionButtons(
        onclick: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Instruction()));
        },
        text: "මිලග",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
