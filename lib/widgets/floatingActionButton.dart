import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

class FloatingActionButtons extends StatelessWidget {
  final VoidCallback? onclick;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  FloatingActionButtons({
    required this.text,
    this.onclick,
    Color? backgroundColor,
    Color? foregroundColor,
    Key? key,
  })  : backgroundColor =
            backgroundColor ?? FlotingActionColors.buttonBackGround,
        foregroundColor =
            foregroundColor ?? FlotingActionColors.buttonForeGround,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.screenWidth * 0.15,
      width: ScreenUtil.screenWidth * 0.5,
      child: ElevatedButton(
        onPressed: onclick,
        child: Text(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
        ),
      ),
    );
  }
}
