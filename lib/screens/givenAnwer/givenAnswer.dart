import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/widgets/surveyoption.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:projectresearch/widgets/textFormField.dart';

class GivenAnswer extends StatefulWidget {
  const GivenAnswer({super.key});

  @override
  State<GivenAnswer> createState() => _GivenAnswerState();
}

class _GivenAnswerState extends State<GivenAnswer> {
  final List<String> surveyOptions = [
    'Not at all easy',
    'Not Easy',
    'Neither easy nor difficult',
    'Easy',
  ];

  List mcqQuestion = [];
  List questionsListforAnswerSheet = [];
  Map yourGivenAnswer = {};
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Answers'),
        ),
        body:
            BlocBuilder<FirebaseBloc, FirebaseState>(builder: (context, state) {
          if (state is answerSheetState) {
            questionsListforAnswerSheet = state.questionsListforAnswerSheet;
            yourGivenAnswer = state.yourGivenAnswer;
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Texts(
                    text: 'MCQ Question',
                    fontSize: 28,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questionsListforAnswerSheet
                        .length, // Number of survey questions
                    itemBuilder: (context, index) {
                      mcqQuestion = questionsListforAnswerSheet;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Texts(
                              text:
                                  '${questionsListforAnswerSheet[index]['questions']}',
                            ),
                          ),
                          for (int i = 0; i < 4; i++)
                            SurveyOption(
                              text: questionsListforAnswerSheet[index]
                                  ['${i + 1}'],
                              color: i ==
                                      questionsListforAnswerSheet[index]
                                          ['correctAnswerIndex']
                                  ? Colors.amber
                                  : i == yourGivenAnswer['$index']
                                      ? Colors.red
                                      : Colors.transparent,
                              icon: i ==
                                      questionsListforAnswerSheet[index]
                                          ['correctAnswerIndex']
                                  ? Icons.check_sharp
                                  : null,
                            ),
                          SizedBox(height: 20.0),
                        ],
                      );
                    },
                  ),
                  Texts(
                    text: 'Structure Question',
                    fontSize: 28,
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Texts(text: 'text'),
                            TextFormFields(
                              text: '$index',
                              controller: controller,
                              isEnable: false,
                            ),
                            Texts(text: 'Correct Answer: '),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        );
                      })
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        }));
  }
}
