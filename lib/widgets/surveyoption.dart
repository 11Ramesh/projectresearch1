import 'package:flutter/material.dart';
import 'package:projectresearch/widgets/text.dart';

class SurveyOption extends StatelessWidget {
  SurveyOption({
    this.fontSize,
    required this.text,
    required this.text1,
    this.color,
    this.icon,
    super.key,
  });

  final double? fontSize;
  final String text;
  final Color? color;
  final IconData? icon;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              offset: Offset(4, 4), // Shadow position
              blurRadius: 10.0, // Shadow blur
              spreadRadius: 1.0, // Shadow spread
            ),
            BoxShadow(
              color:
                  Colors.white.withOpacity(0.8), // Lighter shadow for 3D effect
              offset: Offset(-4, -4), // Shadow position for opposite side
              blurRadius: 10.0, // Shadow blur
              spreadRadius: 1.0, // Shadow spread
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Texts(
              text: text1,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
            Text(
              text,
              style: TextStyle(fontSize: fontSize ?? 15.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
