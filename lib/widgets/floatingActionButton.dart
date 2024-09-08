import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

class FloatingActionButtons extends StatelessWidget {
  final VoidCallback? onclick;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double height;
  final double? fontSize;
  final FontWeight? fontWeight;
  TextAlign? textAlign;

  FloatingActionButtons({
    required this.text,
    double? width,
    double? height,
    this.onclick,
    Color? backgroundColor,
    Color? foregroundColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    Key? key,
  })  : backgroundColor =
            backgroundColor ?? FlotingActionColors.buttonBackGround,
        foregroundColor =
            foregroundColor ?? FlotingActionColors.buttonForeGround,
        width = width ?? ScreenUtil.screenWidth * 0.5,
        height = height ?? ScreenUtil.screenWidth * 0.15,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onclick,
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize ?? 18,
              fontWeight: fontWeight ?? FontWeight.w500),
          textAlign: textAlign,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        ),
      ),
    );
  }
}
