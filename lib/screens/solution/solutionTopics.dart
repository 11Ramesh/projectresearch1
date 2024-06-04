import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:projectresearch/blocs/check/check_bloc.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/screens/solution/summery.dart';
import 'package:projectresearch/screens/solution/video.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';

class SolutionTopics extends StatefulWidget {
  @override
  State<SolutionTopics> createState() => _SolutionTopicsState();
}

class _SolutionTopicsState extends State<SolutionTopics> {
  List finalSolutionToDo = [];
  int countNumber = 0;
  int index = 0;
  late FloatingButtonBloc floatingButtonBloc;
  late CheckBloc checkBlocs;
  int time = 0;
  int topicCount = 0;
  bool isFinishButton = false;

  timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        print(time++);
      });
    });
  }

  @override
  void initState() {
    floatingButtonBloc = BlocProvider.of<FloatingButtonBloc>(context);
    checkBlocs = BlocProvider.of<CheckBloc>(context);
    // timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$time'),
        ),
        body: BlocBuilder<FirebaseBloc, FirebaseState>(
          builder: (context, state) {
            if (state is solutionPart2State) {
              finalSolutionToDo = state.finalSolutionToDo;
              topicCount = state.finalSolutionToDo.length;

              return ListView.builder(
                itemCount: topicCount,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    height: ScreenUtil.screenHeight * 0.1,
                    decoration: BoxDecoration(
                        color: AppbarColors.listViewBackGround,
                        border: Border.all(width: 3, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(finalSolutionToDo[index][0]['topic']),
                      trailing:
                          BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
                        builder: (context, state) {
                          if (state is TopicButtonState) {
                            countNumber = state.countNumber;

                            return elevatedButtons(
                              text: "මිලග",
                              onclick: index <= (countNumber)
                                  ? () {
                                      //put data to CheckBloc
                                      checkBlocs.add(
                                          DataGetSolutionTopicPageEvent(
                                              countNumber,
                                              index,
                                              finalSolutionToDo));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoPage()));
                                    }
                                  : null,
                            );
                          } else {
                            return CircularPercentIndicator(radius: 20);
                          }
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton:
            BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
                builder: (context, state) {
          if (state is TopicButtonState) {
            if (state.countNumber == topicCount) {
              isFinishButton = true;
            }
          }
          return FloatingActionButton(
            onPressed: isFinishButton
                ? () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Summery()));
                  }
                : null,
            child: Text("Finish"),
          );
        }));
  }
}
