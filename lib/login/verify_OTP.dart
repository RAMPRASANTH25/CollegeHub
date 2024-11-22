// ignore_for_file: file_names

import 'package:flutter/material.dart';

class VerifyOTP extends StatefulWidget {
  final String otp;

  const VerifyOTP({super.key, required this.otp});

  @override
  VerifyOTPState createState() => VerifyOTPState();
}

class VerifyOTPState extends State<VerifyOTP> {
  final TextEditingController otpController = TextEditingController();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: showError ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: const Text(
                'Incorrect OTP. Please try again.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Enter the OTP sent to your email',
              style: TextStyle(
                fontSize: 18,
                color: showError ? Colors.transparent : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'OTP: ${widget.otp}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: showError ? Colors.transparent : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              height: showError ? 0 : 60,
              child: TextField(
                controller: otpController,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP',
                  labelText: 'OTP',
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              height: showError ? 0 : 60,
              child: ElevatedButton(
                onPressed: () {
                  // Verify the entered OTP
                  String enteredOTP = otpController.text;
                  if (enteredOTP == widget.otp) {
                    // OTP is correct, you can implement the next steps
                    // For example, allow the user to reset the password
                  } else {
                    // OTP is incorrect, display an error message with animation
                    setState(() {
                      showError = true;
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        showError = false;
                      });
                    });
                  }
                },
                child: const Text('Verify OTP'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
