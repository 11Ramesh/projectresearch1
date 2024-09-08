import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/secondAppbar.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      timeDifference = "$hours hours and $minutes minutes $seconds Seconds";
    } else {
      timeDifference = "Start time not set";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      body: Scaffold(
        //appBar: SecondAppBar(leading: ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Positioned(
                    top: ScreenUtil.screenHeight * 0.2,
                    left: ScreenUtil.screenWidth * 0.3,
                    child: Texts(
                      text: 'සුභ පැතුම්',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                LottieBuilder.asset('assets/conf.json'),
              ],
            ),
            Text(timeDifference),
          ],
        ),
      ),
    );
  }
}
