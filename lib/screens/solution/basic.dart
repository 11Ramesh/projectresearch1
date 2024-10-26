import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
import 'package:projectresearch/widgets/tile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BasicVideo extends StatefulWidget {
  const BasicVideo({super.key});

  @override
  State<BasicVideo> createState() => _BasicVideoState();
}

class _BasicVideoState extends State<BasicVideo> {
  String videoURL = '';
  @override
  void initState() {
    ininialized();
    super.initState();
  }

  ininialized() async {
    try {
      CollectionReference firestore =
          FirebaseFirestore.instance.collection('basic');

      DocumentSnapshot documentSnapshot = await firestore.doc('basic').get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      setState(() {
        videoURL = data['basic'];
      });
    } catch (e) {
      print(e);
    }
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
        body: videoURL == ""
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Height(height: 0.02),
                  Text(
                    'ඉගෙනුම් වීඩියෝ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Height(height: 0.02),
                  Tile(
                    text: "මූලික",
                    color: Colors.blue[300],
                    fontSize: 18,
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                          initialVideoId:
                              YoutubePlayer.convertUrlToId(videoURL)!,
                          flags: const YoutubePlayerFlags(autoPlay: false)),
                      onReady: () => debugPrint('Ready'),
                      showVideoProgressIndicator: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
