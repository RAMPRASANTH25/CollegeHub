import 'package:flutter/material.dart';
import 'package:college_hub/about/about.dart';

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FeedbackForm(),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  FeedbackFormState createState() => FeedbackFormState();
}

class FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _feedbackController = TextEditingController();
  String _feedback = '';

  void _submitFeedback() {
    setState(() {
      _feedback = _feedbackController.text;
    });
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
            title: const Text('Feedback Form'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _feedbackController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Your Feedback',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    'Submit Feedback',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                /*Text(
                  'Feedback: $_feedback',
                  style: const TextStyle(fontSize: 18),
                ),*/
              ],
            ),
          ),
        ));
  }
}
