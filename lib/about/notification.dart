import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  NotifyState createState() => NotifyState();
}

class NotifyState extends State<Notify> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> leaveRequests = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore collection 'leave_requests'
    firestore
        .collection('leave_requests')
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
    final data = request.data() as Map<String, dynamic>;

    // Create a new document in the "accepted_leave" collection with the same data
    firestore.collection('accepted_leave').add(data).then((newDocRef) {
      // Once the data is successfully added to the "accepted_leave" collection,
      // you can remove the request from the list and update its status in the "leave_requests" collection
      firestore
          .collection('leave_requests')
          .doc(request.id)
          .update({"status": "accepted"}).then((_) {
        setState(() {
          leaveRequests.remove(request);
        });
      });
    }).catchError((error) {
      print('Error adding to accepted_leave collection: $error');
    });
  }

  // Function to handle declining a request
  void declineRequest(DocumentSnapshot request) {
    // Update the request status in Firestore as declined
    firestore
        .collection('leave_requests')
        .doc(request.id)
        .update({"status": "declined"}).then((_) {
      // Remove the request from the list
      setState(() {
        leaveRequests.remove(request);
      });
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
