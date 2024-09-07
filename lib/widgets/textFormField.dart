import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';

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
          filled: true,
          fillColor: Color.fromARGB(129, 211, 211, 211),
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
