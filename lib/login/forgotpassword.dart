import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:college_hub/splash/tick.dart';
import 'package:college_hub/login/login.dart';

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  ForgetState createState() => ForgetState();
}

class ForgetState extends State<Forget> {
  final TextEditingController emailController = TextEditingController();
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyLogin(),
            ),
          );
          return false;
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 300),
                  child: const Text(
                    'Forget Your Password',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextField(
                                controller: emailController,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SplashScreen(
                                                    previousRoute: 'forgot',
                                                  )));
                                    },
                                    child: const Text('Continue'),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  String generateRandomOTP() {
    // Generate a random 6-digit OTP
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<bool> sendEmailWithOTP(String recipient, String otp) async {
    final smtpServer = gmail('your_email@gmail.com', 'your_password');

    final message = Message()
      ..from = const Address('your_email@gmail.com', 'Your Name')
      ..recipients.add(recipient)
      ..subject = 'Password Reset OTP'
      ..text = 'Your OTP for password reset is: $otp';

    try {
      final sendReport = await send(message, smtpServer);
      if (sendReport != Null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
