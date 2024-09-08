import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

class Menubutton extends StatelessWidget {
  Menubutton({
    this.fontSize,
    required this.text,
    this.onclick,
    this.foregroundColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.elevation = 4.0,
    this.paddingTop = 10.0,
    this.paddingBottom = 10.0,
    super.key,
  });

  double? fontSize;
  String text;
  VoidCallback? onclick;
  Color foregroundColor;
  Color backgroundColor;
  double elevation;
  double paddingTop;
  double paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: SizedBox(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenWidth * 0.2,
        child: ElevatedButton(
          onPressed: onclick,
          style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor, // Text color
            backgroundColor: backgroundColor, // Button background color
            elevation: elevation, // 3D elevation
            textStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold // Font size
                ),
            shadowColor: Colors.grey[300], // Shadow color for 3D effect
            padding: EdgeInsets.only(
              top: paddingTop,
              bottom: paddingBottom,
            ), // Set top and bottom padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
