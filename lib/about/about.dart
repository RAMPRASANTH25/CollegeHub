import 'package:college_hub/about/leave.dart';
import 'package:college_hub/about/feedbackform.dart';
import 'package:college_hub/about/contact.dart';
import 'package:college_hub/login/reset.dart';
import 'package:college_hub/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _name = '';
  late String _regNo = '';
  late String _email = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        setState(() {
          _name = data['username'];
          _regNo = data['reg no'];
          _email = data['email'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/Cat.jpg'),
              ),
              const SizedBox(height: 20),
              itemProfile('Name', _name, Icons.person),
              const SizedBox(height: 10),
              itemProfile('Reg No', _regNo, Icons.phone),
              const SizedBox(height: 10),
              itemProfile('Email', _email, Icons.mail),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Leave()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Apply Permission'),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackForm()));
                },
                child: paddedRow(Icons.feedback, "Feedback"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Contact()));
                },
                child: paddedRow(Icons.local_post_office_rounded, "Contact Us"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Reset()));
                },
                child: paddedRow(Icons.restore_outlined, "Reset Password"),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyLogin(),
                      ),
                    );
                  });
                },
                child: paddedRow(Icons.logout_outlined, "Logout",
                    textColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paddedRow(IconData iconData, String text, {Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Icon(iconData),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(color: textColor ?? Colors.black),
          ),
        ],
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        tileColor: Colors.white,
      ),
    );
  }
}
