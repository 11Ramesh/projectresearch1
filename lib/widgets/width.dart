import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

class Width extends StatelessWidget {
  Width({
    required this.width,
    super.key,
  });

  double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil.screenHeight * width,
    );
  }
}
