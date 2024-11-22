import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceUpdater extends StatefulWidget {
  @override
  _AttendanceUpdaterState createState() => _AttendanceUpdaterState();
}

class _AttendanceUpdaterState extends State<AttendanceUpdater> {
  final usernameController = TextEditingController();
  bool isAbsent = false;
  bool isPresent = false;
  bool ispAbsent = false;
  bool ispPresent = false;

  void _updateAttendance() async {
    final username = usernameController.text;

    if (username.isEmpty) {
      // You can add error handling here for empty username.
      return;
    }

    final userReference =
        FirebaseFirestore.instance.collection('attendance').doc(username);
    final attendanceReference = userReference.collection('attendance').doc();

    try {
      await attendanceReference.set({
        'theory': {
          'absent': isAbsent,
          'present': isPresent,
        },
        'practical': {
          'absent': ispAbsent,
          'present': ispPresent,
        },
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Attendance updated successfully!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating attendance: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Theory'),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            CheckboxListTile(
              title: Text('Absent'),
              value: isAbsent,
              onChanged: (newValue) {
                setState(() {
                  isAbsent = newValue!;
                  isPresent = !newValue;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Present'),
              value: isPresent,
              onChanged: (newValue) {
                setState(() {
                  isPresent = newValue!;
                  isAbsent = !newValue;
                });
              },
            ),
            Text('Practical'),
            CheckboxListTile(
              title: Text('Absent'),
              value: ispAbsent,
              onChanged: (newValue) {
                setState(() {
                  ispAbsent = newValue!;
                  ispPresent = !newValue;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Present'),
              value: ispPresent,
              onChanged: (newValue) {
                setState(() {
                  ispPresent = newValue!;
                  ispAbsent = !newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: _updateAttendance,
              child: Text('Update Attendance'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: AttendanceUpdater(),
  ));
}
