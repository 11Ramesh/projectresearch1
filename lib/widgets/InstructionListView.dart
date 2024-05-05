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
  List<String> instructions = [
    'ගණිත සවිය ⁣යෙදුමට පිවිසෙන ඔබ සාදරයෙන් පිළිගනිමු. මෙම යෙදුම සංවිධානය කර ඇත්තේ සාමාන්‍ය පෙළ ගණිත විභාගයෙ තුල ඔබගේ ප්‍රගතිය ඉහල නැංවීම සඳහාය.',
    'මෙම යෙදුම තුලින් ඔබගේ දැනුම තුල පවතින ව්‍යූන්තීන් හඳුනාගෙන, ඒවා සම්පූර්ණ කිරීමට ඔබට පුද්ගලිකව සකස් කරන ලද ඉගෙනුම් සම්පත් සපයයි.',
    'ආරම්භ කිරීමට, ඔබ විසින් ඔබගේ ගණිත දැනුම් මට්ටම පරීක්ෂාවක් සම්පූර්ණ කළ යුතුයි.',
    'සමහර ප්‍රශ්නවලට ඔබ පිළිතුරු සපයන්නේ නැතහොත් සුභවාදී නොවන්න. එය ඔබට අතිරික්ත සහාය අවශ්‍ය ක්ෂේත්‍ර හඳුනාගැනීමට උපකාරිය.',
    'මෙම පරීක්ෂණයේ ප්‍රතිඵල මත පදනම්ව, යෙදුම ඔබේ අවශ්‍යතාවන්ට සරිලන විඩියෝ පාඩම්, අන්තර්ක්‍රියාකාරී අභ්‍යාස සහ පූරක සටහන් ලබා දෙනු ඇත.',
    'මෙම සම්පත් ඔබගේ දැනුම තුළ පවතින හිඩැස් සම්පූර්ණ කිරීමට සහ දුෂ්කර සංකල්ප පිළිබඳ අවබෝධය ශක්තිමත් කිරීමට උදවු කරනු ඇත.',
    'ඔබ ඔබේ පුද්ගලික ඉගෙනුම් මාර්ගය හරහා ගමන් කරන විට, යෙදුම ඔබේ ප්‍රගතිය හා කාර්යසාධනය මුණගැසී පවතිනු ඇත. මෙය ඔබට අවශ්‍ය අවම වැඩි සම්පත් ලබාදීම සඳහා ඉගෙනුම් සම්පත් තාවකාලිකව සංශෝධනය කිරීමට අපට අවසර සලසනු ඇත.',
    'මෙම යෙදුමේ ප්‍රධාන වාසිය වන්නේ එහි ප්‍රවේශ්‍යතාවයි. ඔබට සාමාන්‍ය පෙළ ගණිත විභාගයට සූදානම් වීම සඳහා ඔබේ පුද්ගලික ඉගෙනුම් සම්පත්වලට කවර වේලාවක හෝ කොතැනක සිටියදී හෝ ප්‍රවේශ විය හැක. නිවසේදී, පාසලේදී හෝ ගමන් මගදීම එය මතක තබා ගන්න.',
    'මෙම යෙදුම ඔබේ පුද්ගලික ගුරුවරයා ලෙස සැලසුණු අතර, එය ගණිතය තුළ අභියෝගාත්මක සංකල්ප හරහා ඔබව මඟ පෙන්වීමට සහායවන අතර ගණිතය පිළිබඳ කෙටිනොවන පදනමක් ඔබ තුළ ගොඩනැගිය යුතුව පවතී.',
    'මෙම යෙදුම සමඟ අඛණ්ඩ සම්බන්ධතාවයක් පවත්වා ගෙන යාම සහ ඉගෙනුමට කැපවීම ඔබගේ සාමාන්‍ය පෙළ ගණිත විභාගයේදී සාර්ථකත්වයට හේතුවක්ව අනාගතයේදී පවා බලපානු ඇත.'
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
            height: ScreenUtil.screenHeight * 0.20,
            decoration: BoxDecoration(
                color: AppbarColors.listViewBackGround,
                border: Border.all(width: 3, color: Colors.transparent),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text(
                "උපදෙස් (${index + 1})",
              ),
              subtitle: Text(
                " ${instructions[index]}",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        );
      },
    );
  }
}
