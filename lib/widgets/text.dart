import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  Texts({
    this.fontSize,
    required this.text,
    super.key,
  });

  double? fontSize;
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
