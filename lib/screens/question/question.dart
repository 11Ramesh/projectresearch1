import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';

import 'package:projectresearch/screens/question/question_list.dart';
import 'package:projectresearch/screens/question/result.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/radioTile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/textFormField.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  PageController controller = PageController(initialPage: 0);

  List<TextEditingController> answerInput =
      List.generate(30, (index) => TextEditingController());

  List<int?> selectedIndices = List.filled(15, null);
  List<dynamic> correctAnswers = [];
  List<dynamic> correctStructureAnswers = [];
  List<dynamic> structureQuestionData = [];
  List<dynamic> allQuestionId = [];
  List<dynamic> allStructureQuestionId = [];
  List wrongAnswerReferIndexes = [];
  List wrongStuctreAnswerReferIndexes = [];
  List solutionList = [];
  List solutionForWrongAnswer = [];
  int userGiveAnswer = 5;
  bool isgiveAnswer = true;
  String aQuestionId = '';
  int aCorrectAnswerIndex = 0;
  Map<String, dynamic> userSelectIndexList = {'': ''};
  Map<String, dynamic> userInputAnswerIndexList = {'': ''};
  List indexList = [];
  List indexListStucture = [];
  final int x = 0;
  int count = 1;
  int pagecount = 1;
  bool isPage = true;
  int index1 = 0;
  int mcqCount = 0;
  Map<String, dynamic> yourGivenAnswer = {};
  int correctAnswerCount = 0;

  // structure question check . mcq answer check is defind in bloc. its bloc name flotingButtonBlocs.

  StructureQuestionCheck(String id, String answer, int controllerIndex) {
    setState(() {
      if (correctStructureAnswers.contains(id)) {
        //print("have");
        if (answer == answerInput[controllerIndex].text) {
          //  print("Do not repeate");
        } else {
          correctStructureAnswers.remove(id);
          //  print("remove");
        }
      } else if (answer == answerInput[controllerIndex].text) {
        correctStructureAnswers.add(id);
      }

      if (indexListStucture.contains(index1)) {
        userInputAnswerIndexList['$controllerIndex'] =
            answerInput[controllerIndex].text;
      } else {
        indexListStucture.add(index1);
        userInputAnswerIndexList
            .addAll({'$controllerIndex': answerInput[controllerIndex].text});
      }

      //print(userInputAnswerIndexList);
    });
  }

  Future<String> _getImageUrl(String imageUrl) async {
    final Reference ref = FirebaseStorage.instance.ref().child(imageUrl);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    FloatingButtonBloc flotingButtonBlocs =
        BlocProvider.of<FloatingButtonBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              firebaseblock.add(addQuestionEvent());
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<FirebaseBloc, FirebaseState>(
          builder: (context, state) {
            if (state is addQuestionState) {
              mcqCount = state.questionCount;
              //all question id put initialy because send to another block
              allQuestionId = state.questionId;
              // all Stucture quesion id
              allStructureQuestionId = state.structureQuestionId;
              // all Stucture quesion Answer
              structureQuestionData = state.structureQuestionsList;
              return PageView.builder(
                  controller: controller,
                  scrollDirection:
                      Axis.horizontal, // Set the scroll direction to horizontal
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.questionCount + state.structureQuestionCount,
                  itemBuilder: (context, index) {
                    index1 = index;

                    if (index < state.questionCount) {
                      aQuestionId = state.questionId[index];
                      aCorrectAnswerIndex =
                          state.question[index]['correctAnswerIndex'];

                      /// Mcq page
                      return Column(
                        children: [
                          //quection title
                          Text("${state.question[index]['questions']}"),

                          /// add image to strucre
                          FutureBuilder(
                            future:
                                _getImageUrl(state.question[index]['image']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.hasData) {
                                return Image.network(snapshot.data!);
                              } else {
                                return Text('No data');
                              }
                            },
                          ),
                          ////

                          // answers for question
                          for (int i = 0; i < 4; i++)
                            RadioListTile(
                              title: Text(
                                  '${i + 1}     ${state.question[index]['${i + 1}']}'),
                              value: i,
                              groupValue: selectedIndices[index],
                              onChanged: (value) {
                                if (mcqCount + 1 > pagecount) {
                                  // Data send to floating button bloc
                                  flotingButtonBlocs.add(addCorrectAnswerEvent(
                                      value,
                                      aQuestionId,
                                      aCorrectAnswerIndex,
                                      correctAnswers,
                                      index1,
                                      userSelectIndexList,
                                      indexList));
                                }
                                setState(() {
                                  selectedIndices[index] = value;
                                });
                              },
                            ),
                          BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
                              builder: (context, state) {
                            if (state is addCorrectAnswerState) {
                              yourGivenAnswer = state.userGiveAnswer;
                              correctAnswers = state.correctAnswers;
                              print(correctAnswers);
                            }
                            return Container();
                          })
                        ],
                      );
                    } else {
                      ///Structure page
                      return Column(
                        children: [
                          Text(
                              '${state.structureQuestionsList[index - state.questionCount]['questions']}'),

                          /// add image to strucre
                          FutureBuilder(
                            future: _getImageUrl(state.structureQuestionsList[
                                index - state.questionCount]['image']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Container();
                              } else if (snapshot.hasData) {
                                return Image.network(snapshot.data!);
                              } else {
                                return Text('No data');
                              }
                            },
                          ),
                          ////

                          TextFormFields(
                              text: 'Input Answer',
                              controller:
                                  answerInput[index - state.questionCount])
                        ],
                      );
                    }
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: BlocBuilder<FirebaseBloc, FirebaseState>(
          builder: (context, state) {
            if (state is addQuestionState) {
              if (pagecount ==
                  state.questionCount + state.structureQuestionCount) {
                return Row(
                  children: [
                    priviousButton(),
                    finishButton(),
                  ],
                );
              } else {
                return Row(
                  children: [
                    priviousButton(),
                    nextButton(),
                  ],
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget priviousButton() {
    return FloatingActionButtons(
        onclick: () {
          setState(() {
            if (mcqCount < pagecount) {
              StructureQuestionCheck(
                  allStructureQuestionId[index1 - mcqCount],
                  structureQuestionData[index1 - mcqCount]['answer'],
                  (index1 - mcqCount));
            }
            controller.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linear);
            if (pagecount > 1) {
              pagecount--;
            }
          });
        },
        text: "ආපසු");
  }

  Widget nextButton() {
    return FloatingActionButtons(
        onclick: () {
          setState(() {
            if (mcqCount < pagecount) {
              StructureQuestionCheck(
                  allStructureQuestionId[index1 - mcqCount],
                  structureQuestionData[index1 - mcqCount]['answer'],
                  (index1 - mcqCount));
            }

            controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linear);

            pagecount++;
          });
        },
        text: "මිලග");
  }

  Widget finishButton() {
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<FirebaseBloc, FirebaseState>(
          listener: (context, state) {
            if (state is solutionState) {
              wrongAnswerReferIndexes = state.wrongAnswerReferIndexes;
              wrongStuctreAnswerReferIndexes =
                  state.wrongStructureAnswerReferIndexes;

              firebaseblock.add(solutionPart2Event(
                wrongAnswerReferIndexes,
                allQuestionId,
                correctAnswers,
                allStructureQuestionId,
                correctStructureAnswers,
                yourGivenAnswer,
                userInputAnswerIndexList,
              ));
            }
          },
        ),
        BlocListener<FirebaseBloc, FirebaseState>(
          listener: (context, state) {},
        )
      ],
      child: FloatingActionButtons(
          onclick: () {
            if (mcqCount < pagecount) {
              StructureQuestionCheck(
                  allStructureQuestionId[index1 - mcqCount],
                  structureQuestionData[index1 - mcqCount]['answer'],
                  (index1 - mcqCount));
            }
            firebaseblock.add(solutionEvent(
              allQuestionId,
              correctAnswers,
              allStructureQuestionId,
              correctStructureAnswers,
              yourGivenAnswer,
            ));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Result()));
          },
          text: "Finish"),
    );
  }
}
