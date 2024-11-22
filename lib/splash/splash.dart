import 'dart:async';
import 'package:college_hub/login/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyLogin(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/splash.png',
                  fit: BoxFit.contain, // Adjust the BoxFit as needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
