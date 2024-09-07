import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  Texts({
    this.fontSize,
    this.fontWeight,
    required this.text,
    super.key,
  });

  double? fontSize;
  String text;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
