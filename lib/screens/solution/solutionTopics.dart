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
import 'package:projectresearch/screens/question/result.dart';
import 'package:projectresearch/screens/solution/summery.dart';
import 'package:projectresearch/screens/solution/video.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/buttonForSpecificpage.dart';
import 'package:projectresearch/widgets/elevatedButton.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int topicCount = 0;
  bool isFinishButton = false;

  @override

  void initState() {
    floatingButtonBloc = BlocProvider.of<FloatingButtonBloc>(context);
    checkBlocs = BlocProvider.of<CheckBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Result()));
        return false;
      },
      child: Scaffold(
        appBar: MainAppbar(),
        body: Scaffold(
          appBar: SecondAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Result()));
                },
                icon: Icon(Icons.arrow_back_ios_new)),
          ),
          body: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil.screenWidth * 0.03,
                right: ScreenUtil.screenWidth * 0.03),
            child: BlocBuilder<FirebaseBloc, FirebaseState>(
              builder: (context, state) {
                if (state is solutionPart2State) {
                  finalSolutionToDo = state.finalSolutionToDo;
                  topicCount = state.finalSolutionToDo.length;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Height(height: 0.02),
                        Text(
                          'පාඩම් මාලාව',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Height(height: 0.01),
                        ListView.builder(
                          itemCount: topicCount,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal:
                                      12.0), // Add vertical padding for space between tiles
                              child: Container(
                                height: ScreenUtil.screenHeight * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  border: Border.all(
                                      width: 3, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 1, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0,
                                          3), // Offset for the shadow to give a 3D effect
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                      finalSolutionToDo[index][0]['topic']),
                                  trailing: BlocBuilder<FloatingButtonBloc,
                                      FloatingButtonState>(
                                    builder: (context, state) {
                                      if (state is TopicButtonState) {
                                        countNumber = state.countNumber;

                                        return Buttonforspecificpage(
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
                                        return CircularPercentIndicator(
                                            radius: 20);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          floatingActionButton:
              BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
                  builder: (context, state) {
            if (state is TopicButtonState) {
              if (state.countNumber == topicCount) {
                isFinishButton = true;
              }
            }
            return isFinishButton
                ? FloatingActionButtons(
                    text: 'අවසානයි',
                    onclick: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Summery()));
                    },
                  )
                : FloatingActionButtons(
                    text: 'අවසානයි',
                    backgroundColor: Color.fromRGBO(158, 158, 158, 0.679),
                  );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
