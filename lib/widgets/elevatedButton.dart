import 'package:flutter/material.dart';

class elevatedButtons extends StatelessWidget {
  elevatedButtons({
    this.fontSize,
    required this.text,
    this.onclick,
    super.key,
  });

  double? fontSize;
  String text;
  VoidCallback? onclick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onclick,
        child: Text(text),
        style: ElevatedButton.styleFrom());
  }
}
