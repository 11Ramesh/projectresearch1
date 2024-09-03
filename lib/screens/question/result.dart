import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/givenAnwer/givenAnswer.dart';

import 'package:projectresearch/screens/solution/solutionTopics.dart';
import 'package:projectresearch/widgets/circularPresentage.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    FloatingButtonBloc floatingButtonBloc =
        BlocProvider.of<FloatingButtonBloc>(context);
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Texts(text: "ඔබගේ ප්‍රතිඵලය"),
            SizedBox(
              height: 50,
            ),
            presentage(),
            SizedBox(
              height: 20,
            ),
            Texts(text: "ඔබ අවදානය යොමුකල යුතු පාඩාම්"),
            solutionList(),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButtons(
              onclick: () {
                storeTime();
                floatingButtonBloc.add(TopicButtonEvent(-1));

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SolutionTopics()));
              },
              text: "පාඩම් මාලාවට යොමුවන්න"),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GivenAnswer()));
              },
              text: "your answer "),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          print(correctStructureAnswers);
          print(correctAnswers);

          return CircularPresentage(
            percent: (correctAnswerCount + correctStructureAnswers.length) / 10,
            text:
                "${((correctAnswerCount + correctStructureAnswers.length) / 10) * 100}%",
          );
        } else {
          return CircularPresentage(
            percent: 0,
            text: "0%",
          );
        }
      },
    );
  }

  Widget solutionList() {
    return BlocBuilder<FirebaseBloc, FirebaseState>(
      builder: (context, state) {
        if (state is solutionPart2State) {
          if (state.finalSolutionList.isNotEmpty) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.finalSolutionList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                    decoration: BoxDecoration(
                        color: AppbarColors.listViewBackGround,
                        border: Border.all(width: 3, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        // check your flutter bloc when it show any error
                        Text('${state.finalSolutionList[index][0]['topic']}'),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.finalSolutionList[index].length,
                          shrinkWrap: true,
                          itemBuilder: (context, indexsub) {
                            return Container(
                              height: ScreenUtil.screenHeight * 0.1,
                              decoration: BoxDecoration(
                                  color: AppbarColors.listViewBackGround,
                                  border: Border.all(
                                      width: 3, color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                //title: Text("Ramesh"),
                                subtitle: Text(state.finalSolutionList[index]
                                    [indexsub]['subTopic']),
                              ),
                            );
                          },
                        ),
                      ],
                    ));
              },
            );
          } else {
            return Text("congragulation");
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
