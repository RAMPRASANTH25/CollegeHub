import 'package:flutter/material.dart';
import 'package:college_hub/about/about.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

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
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Contact Us'),
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/Cat.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contact Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: CollegeHub@gmail.com',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Phone: 23456789',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pondicherry',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
