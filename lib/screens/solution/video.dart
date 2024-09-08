import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projectresearch/blocs/check/check_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/solution/solutionTopics.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/imageLoading.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
import 'package:projectresearch/widgets/tile.dart';
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
  String topic = "මාතෘකාව";

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
      appBar: MainAppbar(),
      body: Scaffold(
        appBar: SecondAppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new)),
        ),
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
                topic = state.finalSolutionList[index1][0]['topic'];
                return Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil.screenWidth * 0.03,
                      right: ScreenUtil.screenWidth * 0.03),
                  child: PageView.builder(
                    controller: pageControllers,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      isButtonEnabled = index;
                      return (index == 0) ? videoPlayer() : imageBox();
                    },
                  ),
                );
              } else {
                return Text("mad");
              }
            },
          ),
        ),
      ),
      floatingActionButton: isButtonEnabled != 1
          ? nextButton()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                previousButton(),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ); // bloc builder put whole scafold;
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
            text: 'අවසානයි',
            height: ScreenUtil.screenWidth * 0.15,
            width: ScreenUtil.screenWidth * 0.35,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget videoPlayer() {
    return Column(
      children: [
        Height(height: 0.02),
        Text(
          'ඉගෙනුම් වීඩියෝ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Height(height: 0.02),
        Tile(
          text: topic,
          color: Colors.blue[300],
          fontSize: 18,
        ),
        AspectRatio(
          aspectRatio: 16 / 10,
          child: YoutubePlayer(
            controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(videoURL)!,
                flags: const YoutubePlayerFlags(autoPlay: false)),
            onReady: () => debugPrint('Ready'),
            showVideoProgressIndicator: true,
          ),
        ),
      ],
    );
  }

  Widget imageBox() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Height(height: 0.02),
          Text(
            'ඉගෙනුම් සටහන',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Height(height: 0.02),
          Tile(
            text: topic,
            color: Colors.blue[300],
            fontSize: 18,
          ),
          FutureBuilder(
            future: _getImageUrl(imageUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ImageLoading();
              } else if (snapshot.hasError) {
                return Container();
              } else if (snapshot.hasData) {
                return Container(
                    width: ScreenUtil.screenWidth * 0.8,
                    height: ScreenUtil.screenWidth * 1,
                    child: Image.network(snapshot.data!));
              } else {
                return Text('No data');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget nextButton() {
    return FloatingActionButtons(
      onclick: () {
        pageControllers.nextPage(
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
        setState(() {
          isButtonEnabled++;
        });
      },
      text: "මිලග",
      height: ScreenUtil.screenWidth * 0.15,
      width: ScreenUtil.screenWidth * 0.35,
    );
  }

  Widget previousButton() {
    return FloatingActionButtons(
      onclick: () {
        pageControllers.previousPage(
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
        setState(() {
          isButtonEnabled--;
        });
      },
      text: "ආපසු",
      height: ScreenUtil.screenWidth * 0.15,
      width: ScreenUtil.screenWidth * 0.35,
    );
  }
}
