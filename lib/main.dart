import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectresearch/blocs/check/check_bloc.dart';
import 'package:projectresearch/blocs/firebase/firebase_bloc.dart';
import 'package:projectresearch/blocs/floating_button/floating_button_bloc.dart';
import 'package:projectresearch/consts/size/screenSize.dart';
import 'package:projectresearch/screens/Topics.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectresearch/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(),
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<FirebaseBloc>(
          create: (context) => FirebaseBloc(),
        ),
        BlocProvider<FloatingButtonBloc>(
          create: (context) => FloatingButtonBloc(),
        ),
        BlocProvider<CheckBloc>(
          create: (context) => CheckBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
