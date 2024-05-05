import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularPresentage extends StatelessWidget {
  CircularPresentage({
    this.fontSize,
    required this.text,
    required this.percent,
    super.key,
  });

  double? fontSize;
  String text;
  double percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100,
      lineWidth: 20,
      progressColor: Colors.amber,
      percent: percent,
      center: Text(text),
    );
  }
}
