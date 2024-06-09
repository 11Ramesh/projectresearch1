import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(timeDifference),
          ],
        ),
      ),
    );
  }
}
