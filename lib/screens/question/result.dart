import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

import 'package:projectresearch/screens/solution/solutionTopics.dart';
import 'package:projectresearch/widgets/circularPresentage.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

@override
class _ResultState extends State<Result> {
  List solutionForWrongAnswer = [];

  @override
  Widget build(BuildContext context) {
    FloatingButtonBloc floatingButtonBloc =
        BlocProvider.of<FloatingButtonBloc>(context);
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
      floatingActionButton: FloatingActionButtons(
          onclick: () {
            floatingButtonBloc.add(TopicButtonEvent(-1));

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SolutionTopics()));
          },
          text: "පාඩම් මාලාවට යොමුවන්න"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget presentage() {
    return BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
      builder: (context, state) {
        if (state is addCorrectAnswerState) {
          int correctAnswerCount = state.correctAnswers.length;
          print(correctAnswerCount);
          return CircularPresentage(
            percent: correctAnswerCount / 15,
            text: "${(correctAnswerCount / 15) * 100}%",
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
    FirebaseBloc firebaseBloc = BlocProvider.of<FirebaseBloc>(context);
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
