import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';

// ignore: must_be_immutable
class InstructionLists extends StatelessWidget {
  InstructionLists({
    this.height,
    super.key,
  });

  double? height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Container(
            height: ScreenUtil.screenHeight * 0.15,
            decoration: BoxDecoration(
                color: AppbarColors.listViewBackGround,
                border: Border.all(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("උපදෙස් (${index + 1})"),
              subtitle: Text("Insruction ${index + 1}"),
            ),
          ),
        );
      },
    );
  }
}
