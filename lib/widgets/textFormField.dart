import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  final double? fontSize;
  final String text;
  final TextEditingController controller;
  final bool? isEnable;

  TextFormFields({
    this.fontSize,
    required this.text,
    required this.controller,
    this.isEnable = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: isEnable,
        controller: controller,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
