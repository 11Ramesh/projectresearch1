import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/main.dart';
import 'package:projectresearch/screens/Instructions.dart';
import 'package:projectresearch/screens/Topics.dart';
import 'package:projectresearch/screens/givenAnwer/givenAnswer.dart';

import 'package:projectresearch/screens/solution/solutionTopics.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/circularPresentage.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/loading.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

@override
class _ResultState extends State<Result> {
  List solutionForWrongAnswer = [];
  Map<String, dynamic> yourGivenAnswer = {};
  Map<String, dynamic> userInputAnswerIndexList = {};
  int correctAnswerCount = 0;
  List wrongAnswerReferIndexes = [];
  List<dynamic> allQuestionId = [];
  List<dynamic> correctAnswers = [];
  List<dynamic> allStructureQuestionId = [];
  List<dynamic> correctStructureAnswers = [];

  late SharedPreferences startTime;
  String time = '';

  @override
  void initState() {
    getTime();
    super.initState();
  }

  getTime() async {
    startTime = await SharedPreferences.getInstance();
  }

  storeTime() {
    time = DateTime.now().toString();
    startTime.setString('StartTime', time);
  }

  // timerStart() {
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       print(time++);
  //     });
  //   });
  // }

  void showPageLeaveOrNot(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('දැනුම්දීම'),
          content: Text('ඔබට පිටුව හැරදා යාමට අවශ්‍යද ?'),
          actions: <Widget>[
            TextButton(
              child: Text('ඔව්'),
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
            TextButton(
              child: Text('නැත'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FloatingButtonBloc floatingButtonBloc =
        BlocProvider.of<FloatingButtonBloc>(context);
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        showPageLeaveOrNot(context);
        return false;
      },
      child: Scaffold(
        appBar: MainAppbar(),
        body: Scaffold(
          appBar: SecondAppBar(
            leading: IconButton(
                onPressed: () {
                  showPageLeaveOrNot(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
          ),
          body: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil.screenWidth * 0.03,
                right: ScreenUtil.screenWidth * 0.03),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Height(height: 0.03),
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "ඔබගේ ප්‍රතිඵලය",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Height(height: 0.05),
                  presentage(),
                  Height(height: 0.03),
                  solutionList(),
                ],
              ),
            ),
          ),
          floatingActionButton: BlocBuilder<FirebaseBloc, FirebaseState>(
            builder: (context, state) {
              if (state is solutionPart2State) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButtons(
                      onclick: () {
                        storeTime();
                        floatingButtonBloc.add(TopicButtonEvent(-1));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SolutionTopics()));
                      },
                      text: "පාඩම් මාලාවට යොමුවන්න",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      height: ScreenUtil.screenWidth * 0.12,
                      width: ScreenUtil.screenWidth * 0.4,
                    ),
                    SizedBox(width: 15),
                    FloatingActionButtons(
                      onclick: () {
                        firebaseblock.add(answerSheetEvent(
                            yourGivenAnswer,
                            userInputAnswerIndexList,
                            wrongAnswerReferIndexes,
                            allQuestionId,
                            correctAnswers,
                            allStructureQuestionId,
                            correctStructureAnswers));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GivenAnswer()));
                      },
                      text: "ඔබේ පිළිතුරු",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: ScreenUtil.screenWidth * 0.12,
                      width: ScreenUtil.screenWidth * 0.4,
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  Widget presentage() {
    return BlocBuilder<FirebaseBloc, FirebaseState>(
      builder: (context, state) {
        if (state is solutionPart2State) {
          correctAnswerCount = state.correctAnswer.length;
          yourGivenAnswer = state.yourGivenAnswer;
          userInputAnswerIndexList = state.userInputAnswerIndexList;
          wrongAnswerReferIndexes = state.wrongAnswerReferIndexes;
          allQuestionId = state.allQuestion;
          correctAnswers = state.correctAnswer;
          allStructureQuestionId = state.allStructureQuestionId;
          correctStructureAnswers = state.correctStructureAnswers;
          // print(correctStructureAnswers);
          // print(correctAnswers);
          if (correctAnswerCount + correctStructureAnswers.length == 0) {
            return CircularPresentage(
              percent: 0,
              text: "0.00%",
            );
          }
          return CircularPresentage(
            percent: (correctAnswerCount + correctStructureAnswers.length) / 50,
            text:
                "${((correctAnswerCount + correctStructureAnswers.length) / 50) * 100}%",
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget solutionList() {
    return BlocBuilder<FirebaseBloc, FirebaseState>(
      builder: (context, state) {
        if (state is solutionPart2State) {
          if (state.finalSolutionList.isNotEmpty) {
            return Column(
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "ඔබ අවදානය යොමුකල යුතු පාඩාම්",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                Height(height: 0.02),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.finalSolutionList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            //color: AppbarColors.listViewBackGround,
                            border:
                                Border.all(width: 3, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            // check your flutter bloc when it show any error
                            Tile(
                              text:
                                  '${state.finalSolutionList[index][0]['topic']}',
                              color: Colors.blue[100],
                            ),

                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.finalSolutionList[index].length,
                              shrinkWrap: true,
                              itemBuilder: (context, indexsub) {
                                return Container(
                                  decoration: BoxDecoration(
                                    //color: AppbarColors.listViewBackGround,
                                    border: Border.all(
                                        width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      '(${indexsub + 1})  ${state.finalSolutionList[index][indexsub]['subTopic']}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, indexsub) {
                                return SizedBox(
                                    height:
                                        10); // Replace with your desired separator widget
                              },
                            ),
                          ],
                        ));
                  },
                ),
                Height(height: 0.1)
              ],
            );
          } else {
            return Text("congragulation");
          }
        } else {
          return Column(
            children: [
              Height(height: 0.2),
              Loading(),
            ],
          );
        }
      },
    );
  }
}
