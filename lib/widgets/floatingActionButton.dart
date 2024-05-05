import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

class FloatingActionButtons extends StatelessWidget {
  FloatingActionButtons({
    required this.onclick,
    required this.text,
    Key? key,
  }) : super(key: key);

  VoidCallback onclick;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.screenWidth * 0.15,
      width: ScreenUtil.screenWidth * 0.5,
      // child: FloatingActionButton(
      //   mini: true,
      //   elevation: 0,
      //   onPressed: onclick,
      //   child: Text(text),
      //   backgroundColor: FlotingActionColors.buttonBackGround,
      //   foregroundColor: FlotingActionColors.buttonForeGround,
      // ),
      child: ElevatedButton(
        onPressed: onclick,
        child: Text(text),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              FlotingActionColors.buttonBackGround),
          foregroundColor: MaterialStateProperty.all<Color>(
              FlotingActionColors.buttonForeGround),
        ),
      ),
    );
  }
}
