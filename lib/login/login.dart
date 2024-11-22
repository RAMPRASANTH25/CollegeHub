import 'package:college_hub/dashboard.dart';
import 'package:college_hub/login/teacher.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_hub/login/forgotpassword.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  MyLoginState createState() {
    return MyLoginState();
  }
}

class MyLoginState extends State<MyLogin> {
  var _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginFailed = false;
  double _errorOpacity = 0.0;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding: const EdgeInsets.only(left: 10, top: 250),
              child: const Text(
                'Sign in to your \nAccount',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 30,
                ),
              ),
            ),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
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
                            TextField(
                              controller: _passwordController,
                              style: const TextStyle(),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              height: _loginFailed ? 100 : 0,
                              child: Opacity(
                                opacity: _errorOpacity,
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 255, 3, 3),
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Column(
                                    children: [
                                      Text(
                                        'Login failed',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Please check your email and password.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    signIn(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff162B72),
                                  ),
                                  child: const Text('Login'),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Forget()));
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "staff") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TeachDash(),
            ),
          );
        } else if (documentSnapshot.get('role') == "hod") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TeachDash(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Dash(),
            ),
          );
        }
      } else {}
    });
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential.user != null) {
          route();
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _loginFailed = true;
          _errorOpacity = 1.0;
        });
        if (e.code == 'user-not-found') {
        } else if (e.code == 'wrong-password') {}
      }
    }
  }
}
