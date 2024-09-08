import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:projectresearch/main.dart';
import 'package:projectresearch/screens/Topics.dart';
import 'package:projectresearch/widgets/Topiclistview.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Animation duration (2 seconds)
    );

    // Define the type of animation
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut, // Smooth transition curve
    );

    // Start the animation
    _controller?.forward();

    // Navigate to home after the animation completes
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.green,
            ], // Background gradient colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers the content vertically
            children: [
              FadeTransition(
                  opacity: _animation!, child: Image.asset('assets/logo.png')),
              const SpinKitCircle(
                color: Colors.blue,
                size: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
