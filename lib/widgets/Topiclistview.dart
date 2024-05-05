import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';

// ignore: must_be_immutable
class TopicLists extends StatelessWidget {
  TopicLists({
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
            height: height,
            decoration: BoxDecoration(
                color: AppbarColors.listViewBackGround,
                border: Border.all(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text("(${index + 1}.)"),
            ),
          ),
        );
      },
    );
  }
}
