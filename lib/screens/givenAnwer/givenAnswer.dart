import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/imageLoading.dart';
import 'package:projectresearch/widgets/loading.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
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
  List StructureQuestionsListforAnswerSheet = [];
  Map<String, dynamic> yourGivenAnswer = {};
  Map<String, dynamic> userInputAnswerIndexList = {};
  TextEditingController controller = TextEditingController();
  List wrongAnswerReferIndexes = [];
  List<dynamic> allQuestionId = [];
  List<dynamic> correctAnswers = [];
  List<dynamic> allStructureQuestionId = [];
  List<dynamic> correctStructureAnswers = [];

  Future<String> _getImageUrl(String imageUrl) async {
    final Reference ref = FirebaseStorage.instance.ref().child(imageUrl);
    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return Scaffold(
      appBar: MainAppbar(),
      body: Scaffold(
          appBar: SecondAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                firebaseblock.add(solutionPart2Event(
                  wrongAnswerReferIndexes,
                  allQuestionId,
                  correctAnswers,
                  allStructureQuestionId,
                  correctStructureAnswers,
                  yourGivenAnswer,
                  userInputAnswerIndexList,
                ));

                Navigator.pop(context);
              },
            ),
          ),
          body: BlocBuilder<FirebaseBloc, FirebaseState>(
              builder: (context, state) {
            if (state is answerSheetState) {
              questionsListforAnswerSheet = state.questionsListforAnswerSheet;
              StructureQuestionsListforAnswerSheet =
                  state.StructureQuestionsListforAnswerSheet;
              yourGivenAnswer = state.yourGivenAnswer;
              userInputAnswerIndexList = state.userInputAnswerIndexList;
              wrongAnswerReferIndexes = state.wrongAnswerReferIndexes;
              allQuestionId = state.allQuestionId;
              correctAnswers = state.correctAnswers;
              allStructureQuestionId = state.allStructureQuestionId;
              correctStructureAnswers = state.correctStructureAnswers;

              //print(userInputAnswerIndexList);
              return Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.screenWidth * 0.03,
                    right: ScreenUtil.screenWidth * 0.03),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Height(height: 0.05),
                      const Text(
                        'MCQ ප්‍රශ්න',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Texts(
                                  text:
                                      '(${index + 1}) ${questionsListforAnswerSheet[index]['questions']}',
                                ),
                              ),
                              //mcq
                              FutureBuilder(
                                future: _getImageUrl(
                                    state.questionsListforAnswerSheet[index]
                                        ['image']),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return ImageLoading();
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else if (snapshot.hasData) {
                                    return Container(
                                        width: ScreenUtil.screenWidth * 0.6,
                                        height: ScreenUtil.screenWidth * 0.6,
                                        child: Image.network(snapshot.data!));
                                  } else {
                                    return Text('No data');
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              for (int i = 0; i < 4; i++)
                                SurveyOption(
                                  text: questionsListforAnswerSheet[index]
                                      ['${i + 1}'],
                                  color: i ==
                                              questionsListforAnswerSheet[index]
                                                  ['correctAnswerIndex'] &&
                                          i == yourGivenAnswer['$index']
                                      ? Colors.green
                                      : i ==
                                              questionsListforAnswerSheet[index]
                                                  ['correctAnswerIndex']
                                          ? Colors.amber
                                          : i == yourGivenAnswer['$index']
                                              ? Colors.red
                                              : Colors.white,
                                  text1: i ==
                                          questionsListforAnswerSheet[index]
                                              ['correctAnswerIndex']
                                      ? 'නිවැරදි පිළිතුර : '
                                      : '',
                                ),
                              SizedBox(height: 20.0),
                            ],
                          );
                        },
                      ),
                      Height(height: 0.05),
                      const Text(
                        'ව්‍යුහාත්මක ප්‍රශ්න',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      Height(height: 0.02),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              StructureQuestionsListforAnswerSheet.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Texts(
                                    text: StructureQuestionsListforAnswerSheet[
                                        index]['questions']),
                                SizedBox(height: 20.0),
                                FutureBuilder(
                                  future: _getImageUrl(
                                      StructureQuestionsListforAnswerSheet[
                                          index]['image']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ImageLoading();
                                    } else if (snapshot.hasError) {
                                      return Container();
                                    } else if (snapshot.hasData) {
                                      return Container(
                                          width: ScreenUtil.screenWidth * 0.6,
                                          height: ScreenUtil.screenWidth * 0.6,
                                          child: Image.network(snapshot.data!));
                                    } else {
                                      return Text('No data');
                                    }
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormFields(
                                  text: '${userInputAnswerIndexList['$index']}',
                                  controller: controller,
                                  isEnable: false,
                                ),
                                Texts(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    text:
                                        'Correct Answer:  ${StructureQuestionsListforAnswerSheet[index]['answer']}'),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            );
                          })
                    ],
                  ),
                ),
              );
            } else {
              return Loading();
            }
          })),
    );
  }
}
