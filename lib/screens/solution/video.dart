import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectresearch/blocs/check/check_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/screens/solution/solutionTopics.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  int countNumber = 0;
  int countNumber1 = 0;
  int index1 = 0;
  int index = 0;
  int isButtonEnabled = 0;
  List finalSolutionList = [];
  late FloatingButtonBloc floatingButtonBloc;
  late YoutubePlayerController _controller;
  String videoURL = " ";
  late PageController pageControllers = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    floatingButtonBloc = BlocProvider.of<FloatingButtonBloc>(context);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: 500,
        child: BlocBuilder<CheckBloc, CheckState>(
          builder: (context, state) {
            if (state is DataGetSolutionTopicPageState) {
              countNumber1 = state.countNumber;
              index1 = state.index;
              finalSolutionList = state.finalSolutionList;
              videoURL = state.finalSolutionList[index1][0]['youtube'];
              return PageView.builder(
                controller: pageControllers,
                itemCount: 3,
                itemBuilder: (context, index) {
                  isButtonEnabled = index;
                  return (index == 0)
                      ? Text("note")
                      : (index == 1)
                          ? videoPlayer()
                          : Text("image");
                },
              );
            } else {
              return Text("mad");
            }
          },
        ),
      ),
      floatingActionButton: isButtonEnabled != 2
          ? Row(
              children: [
                previousButton(),
                nextButton(),
              ],
            )
          : FloatingActionButton(),
    );
  }

  Widget FloatingActionButton() {
    return BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
      builder: (context, state) {
        if (state is TopicButtonState) {
          countNumber = state.countNumber;
          return FloatingActionButtons(
              onclick: () {
                if (countNumber1 == index1) {
                  floatingButtonBloc.add(TopicButtonEvent(countNumber));
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SolutionTopics()));
              },
              text: 'Finish');
        } else {
          return Container();
        }
      },
    );
  }

  Widget videoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: YoutubePlayer(
        controller: YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoURL)!,
            flags: const YoutubePlayerFlags(autoPlay: false)),
        onReady: () => debugPrint('Ready'),
        showVideoProgressIndicator: true,
      ),
    );
  }

  Widget nextButton() {
    return FloatingActionButtons(
        onclick: () {
          pageControllers.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
          setState(() {
            isButtonEnabled++;
          });
        },
        text: "Next");
  }

  Widget previousButton() {
    return FloatingActionButtons(
        onclick: () {
          pageControllers.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
          setState(() {
            isButtonEnabled--;
          });
        },
        text: "Previous");
  }
}
