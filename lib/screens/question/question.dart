import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/screens/question/question_list.dart';
import 'package:projectresearch/screens/question/result.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/radioTile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  PageController controller = PageController(initialPage: 0);
  List<int?> selectedIndices = List.filled(15, null);
  List<dynamic> correctAnswers = [];
  List<dynamic> allQuestionId = [];
  List wrongAnswerReferIndexes = [];
  List solutionList = [];
  List solutionForWrongAnswer = [];
  final int x = 0;
  int count = 1;
  int pagecount = 1;
  @override
  Widget build(BuildContext context) {
    FloatingButtonBloc flotingButtonBlocs =
        BlocProvider.of<FloatingButtonBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<FirebaseBloc, FirebaseState>(
          builder: (context, state) {
            if (state is addQuestionState) {
              //all question id put initialy because send to another block
              allQuestionId = state.questionId;
              return PageView.builder(
                  controller: controller,
                  scrollDirection:
                      Axis.horizontal, // Set the scroll direction to horizontal
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.questionCount,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        //quection title
                        Text("${state.question[index]['questions']}"),
                        // answers for question
                        for (int i = 0; i < 4; i++)
                          RadioListTile(
                            title: Text(
                                '${i + 1}     ${state.question[index]['${i + 1}']}'),
                            value: i,
                            groupValue: selectedIndices[index],
                            onChanged: (value) {
                              // Data send to floating button bloc
                              flotingButtonBlocs.add(addCorrectAnswerEvent(
                                  value,
                                  state.questionId[index],
                                  state.question[index]['correctAnswerIndex'],
                                  correctAnswers));

                              setState(() {
                                selectedIndices[index] = value;
                              });
                            },
                          ),
                      ],
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: BlocBuilder<FirebaseBloc, FirebaseState>(
          builder: (context, state) {
            if (state is addQuestionState) {
              if (pagecount == 15) {
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

              firebaseblock.add(solutionPart2Event(wrongAnswerReferIndexes));
            }
          },
        ),
        BlocListener<FirebaseBloc, FirebaseState>(
          listener: (context, state) {},
        )
      ],
      child: FloatingActionButtons(
          onclick: () {
            firebaseblock.add(solutionEvent(allQuestionId, correctAnswers));

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Result()));
          },
          text: "Finish"),
    );
  }
}
