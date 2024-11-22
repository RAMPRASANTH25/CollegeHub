import 'package:college_hub/splash/tick.dart';
import 'package:college_hub/about/about.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  LeaveState createState() => LeaveState();
}

class LeaveState extends State<Leave> {
  TextEditingController reasonController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;
  String? username;

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<String> fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      final data = snapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        return data['username'];
      }
      return "";
    }
    return '';
  }

  void pushDataToDatabase(String requestType) async {
    final String reason = reasonController.text;
    final String startDate = startDateController.text;
    final String endDate = endDateController.text;

    Map<String, dynamic> leaveData = {
      'reason': reason,
      'start_date': startDate,
      'end_date': endDate,
      'name': await fetchUsername(),
      'request_type': requestType,
      'status': 'pending',
    };

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('leave_requests')
          .add(leaveData)
          .then((value) {
        // Successfully added data to Firestore
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SplashScreen(previousRoute: 'leave'),
        ));
      }).catchError((error) {});
    }
  }

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
            title: const Text('Request Permission'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reason:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your reason for Permission',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Start Date:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                    hintText: 'DD-MM-YYYY',
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                const Text(
                  'No of Days',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                    hintText: 'Enter the No Of Days',
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    pushDataToDatabase(
                        'leave request'); // Send as 'leave request'
                  },
                  child: const Text('SEND REQUEST'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    pushDataToDatabase('on duty'); // Send as 'on duty'
                  },
                  child: const Text('SEND ON-DUTY'),
                ),
              ],
            ),
          ),
        ));
  }
}
