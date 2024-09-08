import 'package:flutter/material.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/Topics.dart';
import 'package:projectresearch/widgets/appbar.dart';
import 'package:projectresearch/widgets/menuButton.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MainAppbar(),
        body: Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil.screenWidth * 0.04,
              right: ScreenUtil.screenWidth * 0.04),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                    height: ScreenUtil.screenHeight * 0.3,
                    child: Image.asset('assets/logo.png')),
                Menubutton(
                  text: 'දැනුම් පරීක්ෂණය',
                  fontSize: 20,
                  elevation: 6.0,
                  backgroundColor: Color.fromARGB(255, 97, 229, 252),
                  onclick: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                Menubutton(
                  text: 'ස්ව්‍යංක්‍රීය සහාය ලබා ගැනීම',
                  fontSize: 20,
                  elevation: 6.0,
                  backgroundColor: Color.fromARGB(255, 97, 229, 252),
                  onclick: () {
                    // Button click action
                  },
                ),
                Menubutton(
                  text: '3D සහය ලබා ගැනීම',
                  fontSize: 20,
                  elevation: 6.0,
                  backgroundColor: Color.fromARGB(255, 97, 229, 252),
                  onclick: () {
                    // Button click action
                  },
                ),
                Menubutton(
                  text: 'ප්‍රශ්ණ පත්‍ර',
                  fontSize: 20,
                  backgroundColor: Color.fromARGB(255, 97, 229, 252),
                  elevation: 6.0,
                  onclick: () {
                    // Button click action
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
