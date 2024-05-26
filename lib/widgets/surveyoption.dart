import 'package:flutter/material.dart';

class SurveyOption extends StatelessWidget {
  SurveyOption({
    this.fontSize,
    required this.text,
    this.color,
    this.icon,
    super.key,
  });

  double? fontSize;
  String text;
  Color? color;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Text(
                text,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}
