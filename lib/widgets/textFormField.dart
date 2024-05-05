import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  TextFormFields({
    this.fontSize,
    required this.text,
    required this.controller,
    super.key,
  });

  double? fontSize;
  String text;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
