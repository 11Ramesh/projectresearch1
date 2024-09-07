import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

class Height extends StatelessWidget {
  Height({
    required this.height,
    super.key,
  });

  double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil.screenHeight * height,
    );
  }
}
