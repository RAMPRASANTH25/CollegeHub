import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnterMarksScreen extends StatefulWidget {
  const EnterMarksScreen({super.key});

  @override
  _EnterMarksScreenState createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends State<EnterMarksScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController obtainedScoreController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Marks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: scoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Score'),
            ),
            TextField(
              controller: obtainedScoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Obtained Score'),
            ),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(labelText: 'Grade'),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final firestore = FirebaseFirestore.instance;
                final username = usernameController.text;
                final subject = subjectController.text;
                final score = int.parse(scoreController.text);
                final obtainedScore = int.parse(obtainedScoreController.text);
                final grade = gradeController.text;
                final userQuery = await firestore
                    .collection('user')
                    .where('username', isEqualTo: username)
                    .get();

                if (userQuery.docs.isEmpty) {
                  print('Username not found.');
                  return;
                }

                final userDoc = userQuery.docs.first;
                final userUID = userDoc.id;

                try {
                  await firestore
                      .collection('user')
                      .doc(userUID)
                      .collection('scores')
                      .doc('cat1')
                      .update({
                    'subjects': FieldValue.arrayUnion([
                      {
                        'subject': subject,
                        'obtainedScore': obtainedScore,
                        'grade': grade,
                        'score': score,
                      }
                    ]),
                  });
                } catch (e) {
                  print('Error updating data: $e');
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
