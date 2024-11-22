import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class hodnotify extends StatefulWidget {
  const hodnotify({super.key});

  @override
  hodnotifyState createState() => hodnotifyState();
}

class hodnotifyState extends State<hodnotify> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> leaveRequests = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore collection 'accepted_leave'
    firestore
        .collection('accepted_leave')
        .where('status', isEqualTo: 'pending')
        .get()
        .then((querySnapshot) {
      setState(() {
        leaveRequests = querySnapshot.docs;
      });
    });
  }

  // Function to handle accepting a request
  void acceptRequest(DocumentSnapshot request) {
    // TODO: Update the request status in Firestore as accepted
    // Remove the request from the list
    firestore
        .collection('accepted_leave')
        .doc(request.id)
        .update({"status": "accept"});
    setState(() {
      leaveRequests.remove(request);
    });
  }

  // Function to handle declining a request
  void declineRequest(DocumentSnapshot request) {
    // TODO: Update the request status in Firestore as declined
    firestore
        .collection('accepted_leave')
        .doc(request.id)
        .update({"status": "decline"});

    // Remove the request from the list
    setState(() {
      leaveRequests.remove(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
      ),
      body: ListView.builder(
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          final leaveData = leaveRequests[index].data() as Map<String, dynamic>;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('${leaveData['request_type']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${leaveData['name']}'),
                      Text('Reason: ${leaveData['reason']}'),
                      Text('Start Date: ${leaveData['start_date']}'),
                      Text('End Date: ${leaveData['end_date']}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        acceptRequest(leaveRequests[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Accept'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        declineRequest(leaveRequests[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Decline'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
