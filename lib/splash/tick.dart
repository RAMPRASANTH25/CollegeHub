import 'dart:async';
import 'package:flutter/material.dart';
import 'package:college_hub/login/forgotpassword.dart';
import 'package:college_hub/about/leave.dart';
import 'package:college_hub/login/reset.dart';

class SplashScreen extends StatefulWidget {
  final String previousRoute; // Add this parameter

  const SplashScreen({Key? key, required this.previousRoute}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (widget.previousRoute == 'forgot') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Forget(),
        ));
      } else if (widget.previousRoute == 'leave') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Leave(),
        ));
      } else if (widget.previousRoute == 'reset') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Reset(),
        ));
      } else {
        // Handle other cases or defaults
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/tick.png',
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}
