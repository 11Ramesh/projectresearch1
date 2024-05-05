import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';

// ignore: must_be_immutable
class TopicLists extends StatelessWidget {
  TopicLists({
    this.height,
    super.key,
  });

  double? height;
  List<String> Topics = [
    'භාග',
    'ප්‍රතිශත',
    'සමාන්තර ශ්‍රේණි ',
    'ඝන වස්තුවල පරිමාව',
    'කොටස් වෙළදපොල',
    'මධ්‍ය ලක්ශ්‍ය ප්‍රමේයය',
    'ගුනෝත්තර ශ්‍රේණි',
    'පයිතගරස් ප්‍රමේයය',
    'අසමානතා',
    'නිර්මාණ'
  ];

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
              title: Text("${Topics[index]}"),
            ),
          ),
        );
      },
    );
  }
}
