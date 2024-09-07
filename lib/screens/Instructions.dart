import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/consts/colors/colors.dart';

import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/data.dart';
import 'package:projectresearch/screens/question/question.dart';
import 'package:projectresearch/widgets/InstructionListView.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/floatingActionButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/widgets/height.dart';
import 'package:projectresearch/widgets/text.dart';
import 'package:projectresearch/widgets/tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Instruction extends StatefulWidget {
  const Instruction({super.key});

  @override
  State<Instruction> createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  late SharedPreferences mcq;

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    mcq = await SharedPreferences.getInstance();
    randomizeAndSave();
  }

  void randomizeAndSave() {
    int randomNumber = Random().nextInt(2) + 1;
    print(randomNumber);

    mcq.setInt('mcq', randomNumber);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseBloc firebaseblock = BlocProvider.of<FirebaseBloc>(context);
    return Scaffold(
      appBar: MainAppbar(),
      body: Scaffold(
        appBar: AppBar(
          title: Texts(
            text: "පරීක්ෂණය සදහා උපදෙස්",
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil.screenWidth * 0.03,
                right: ScreenUtil.screenWidth * 0.03),
            child: Column(
              children: [
                Height(height: 0.05),
                Texts(
                  text: 'ගණිත සවිය ⁣යෙදුමට පිවිසෙන ඔබ සාදරයෙන් පිළිගනිමු!. ',
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.screenWidth < 420 ? 13 : 16,
                ),
                Height(height: 0.02),
                Texts(
                  text:
                      'මෙම යෙදුම සංවිධානය කර ඇත්තේ සාමාන්‍ය පෙළ ගණිත විභාගයෙ තුල ඔබගේ ප්‍රගතිය ඉහල නැංවීම සඳහාය. මෙම යෙදුම තුලින් ඔබගේ දැනුම තුල පවතින ව්‍යූන්තීන් හඳුනාගෙන, ඒවා සම්පූර්ණ කිරීමට ඔබට පුද්ගලිකව සකස් කරන ලද ඉගෙනුම් සම්පත් සපයයි.',
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.screenWidth < 420 ? 13 : 16,
                ),
                Height(height: 0.02),
                Tile(text: 'උපදෙස්'),
                InstructionLists(),
                Height(height: 0.15),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtons(
        text: "පරීක්ෂණය සදහා යොමුවන්න",
        onclick: () {
          initializeSharedPreferences();
          firebaseblock.add(addQuestionEvent());

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Question()));
          print(ScreenUtil.screenWidth);
        },
        backgroundColor: FlotingActionColors.buttonBackGround,
        width: ScreenUtil.screenWidth * 0.8,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
