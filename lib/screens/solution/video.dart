import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectresearch/blocs/check/check_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/solution/solutionTopics.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/imageLoading.dart';
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
  String imageUrl = " ";
  late PageController pageControllers = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    floatingButtonBloc = BlocProvider.of<FloatingButtonBloc>(context);
  }

  Future<String> _getImageUrl(String imageUrl) async {
    final Reference ref =
        FirebaseStorage.instance.ref("solution/").child(imageUrl);
    return await ref.getDownloadURL();
  }

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
              imageUrl = state.finalSolutionList[index1][0]['image'];
              return PageView.builder(
                controller: pageControllers,
                itemCount: 2,
                itemBuilder: (context, index) {
                  isButtonEnabled = index;
                  return (index == 0) ? videoPlayer() : imageBox();
                },
              );
            } else {
              return Text("mad");
            }
          },
        ),
      ),
      floatingActionButton: isButtonEnabled != 1
          ? nextButton()
          : Row(
              children: [
                previousButton(),
                FloatingActionButton(),
              ],
            ),
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

  Widget imageBox() {
    return FutureBuilder(
      future: _getImageUrl(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
