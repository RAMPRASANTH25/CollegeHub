import 'package:flutter/material.dart';
import 'package:college_hub/splash/tick.dart';
import 'package:college_hub/about/about.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);
  @override
  ResetState createState() => ResetState();
}

class ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfileScreen(),
            ),
          );
          return false;
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 300),
                  child: const Text(
                    'Reset Your Password',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextField(
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SplashScreen(
                                                    previousRoute: 'reset',
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    ),
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
}
