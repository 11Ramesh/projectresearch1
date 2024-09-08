import 'package:flutter/material.dart';

class Buttonforspecificpage extends StatelessWidget {
  Buttonforspecificpage({
    this.fontSize,
    required this.text,
    this.onclick,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  final double? fontSize;
  final String text;
  final VoidCallback? onclick;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? Colors.blue[500], // Background color
        foregroundColor: foregroundColor ?? Colors.white, // Text color
        textStyle: TextStyle(
          fontSize: fontSize ?? 16.0, // Font size
        ),
      ),
      child: Text(
        text,
      ),
    );
  }
}
