import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/widgets/text.dart';

// ignore: must_be_immutable
class InstructionLists extends StatelessWidget {
  InstructionLists({
    this.height,
    super.key,
  });

  double? height;
  List<String> instructions = [
    'ආරම්භ කිරීමට, ඔබ විසින් ඔබගේ ගණිත දැනුම් මට්ටම පරීක්ෂාවක් සම්පූර්ණ කළ යුතුයි.',
    'මෙම පරීක්ෂණයේ ප්‍රතිඵල මත පදනම්ව, යෙදුම ඔබේ අවශ්‍යතාවන්ට සරිලන විඩියෝ පාඩම්, අන්තර්ක්‍රියාකාරී අභ්‍යාස සහ පූරක සටහන් ලබා දෙනු ඇත',
    'මෙම සම්පත් ඔබගේ දැනුම තුළ පවතින හිඩැස් සම්පූර්ණ කිරීමට සහ දුෂ්කර සංකල්ප පිළිබඳ අවබෝධය ශක්තිමත් කිරීමට උදවු කරනු ඇත.',
    'මෙම යෙදුමේ ප්‍රධාන වාසිය වන්නේ එහි ප්‍රවේශ්‍යතාවයි. ඔබට සාමාන්‍ය පෙළ ගණිත විභාගයට සූදානම් වීම සඳහා ඔබේ පුද්ගලික ඉගෙනුම් සම්පත්වලට කවර වේලාවක හෝ කොතැනක සිටියදී හෝ ප්‍රවේශ විය හැක. නිවසේදී, පාසලේදී හෝ ගමන් මගදීම එය මතක තබා ගන්න.',
    'මෙම යෙදුම ඔබේ පුද්ගලික ගුරුවරයා ලෙස සැලසුණු අතර, එය ගණිතය තුළ අභියෝගාත්මක සංකල්ප හරහා ඔබව මඟ පෙන්වීමට සහායවන අතර ගණිතය පිළිබඳ කෙටිනොවන පදනමක් ඔබ තුළ ගොඩනැගිය යුතුව පවතී.',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 10),
          child: Container(
            height: ScreenUtil.screenHeight * 0.2,
            decoration: BoxDecoration(
                color: AppbarColors.listViewBackGround,
                border: Border.all(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
                // title: Text(
                //   "උපදෙස් (${index + 1})",
                // ),
                subtitle: Texts(
              text: "(${index + 1})  ${instructions[index]}",
              fontSize: ScreenUtil.screenWidth < 420 ? 13 : 16,
              fontWeight: FontWeight.bold,
            )),
          ),
        );
      },
    );
  }
}
