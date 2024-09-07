import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';

class Tile extends StatelessWidget {
  Tile({
    this.fontSize,
    required this.text,
    super.key,
  });

  double? fontSize;
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: AppbarColors.listViewBackGround,
            border: Border.all(width: 3, color: Colors.transparent),
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.center,
        ),
      ),
    );
  }
}
