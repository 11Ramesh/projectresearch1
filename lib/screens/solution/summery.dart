import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Summery extends StatefulWidget {
  const Summery({super.key});

  @override
  State<Summery> createState() => _SummeryState();
}

class _SummeryState extends State<Summery> {
  late SharedPreferences startTime;
  String? statTimes;
  String timeDifference = "";

  @override
  void initState() {
    super.initState();
    getTime();
  }

  getTime() async {
    startTime = await SharedPreferences.getInstance();
    setState(() {
      statTimes = startTime.getString('StartTime');
      calculateTimeDifference();
    });
  }

  void calculateTimeDifference() {
    if (statTimes != null) {
      DateTime startDateTime = DateTime.parse(statTimes!);
      DateTime timenow = DateTime.now();
      Duration difference = timenow.difference(startDateTime);

      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60);
      int seconds = difference.inSeconds.remainder(60);

      timeDifference = "$hours පැය $minutes මිනිත්තු $seconds තත්පර";
    } else {
      timeDifference = "Start time not set";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: Scaffold(
        appBar: SecondAppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    top: ScreenUtil.screenHeight * 0.25,
                    left: ScreenUtil.screenWidth * 0.3,
                    child: Texts(
                      text: 'සුභ පැතුම්',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                LottieBuilder.asset('assets/conf.json'),
              ],
            ),
            Text(
              'අධ්‍යනය සදහා ගත කල කාලය ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Height(height: 0.01),
            Text(timeDifference,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
        floatingActionButton: FloatingActionButtons(
          onclick: () async {
            const url = 'https://beta.dpeducation.lk/en/';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              throw 'Could not launch $url';
            }
          },
          text: 'වැඩිදුර ඉගෙනීම\n(DP Education)',
          fontSize: 12,
          height: ScreenUtil.screenWidth * 0.1,
          width: ScreenUtil.screenWidth * 0.35,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
