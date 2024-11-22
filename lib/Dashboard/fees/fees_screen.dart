import 'package:flutter/material.dart';
import 'package:college_hub/constant.dart';
import 'package:college_hub/Dashboard/fees/fee_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore

class FeeScreen extends StatefulWidget {
  const FeeScreen({Key? key}) : super(key: key);
  static String routeName = 'FeeScreen';

  @override
  FeeScreenState createState() => FeeScreenState();
}

class FeeScreenState extends State<FeeScreen> {
  late String userUID;
  List<DocumentSnapshot> feeStructure = [];

  @override
  void initState() {
    super.initState();
    fetchUserUID();
  }

  Future<void> fetchUserUID() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userUID = user.uid;
      });
      fetchFeeStructureDataForUser();
    }
  }

  Future<void> fetchFeeStructureDataForUser() async {
    if (userUID.isNotEmpty) {
      // Fetch user-specific data based on their UID from the 'users' collection
      DocumentReference userDocReference =
          FirebaseFirestore.instance.collection('user').doc(userUID);
      DocumentSnapshot userSnapshot = await userDocReference.get();

      if (userSnapshot.exists) {
        final userEmail = userSnapshot.get('email');

        // Fetch fee structure data for the user based on their email
        CollectionReference feesCollection =
            FirebaseFirestore.instance.collection('fees');
        QuerySnapshot querySnapshot =
            await feesCollection.where('email', isEqualTo: userEmail).get();

        setState(() {
          feeStructure = querySnapshot.docs;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Structure'),
      ),
      body: feeStructure.isEmpty
          ? const Center(
              child: Text(''),
            )
          : ListView.builder(
              itemCount: feeStructure.length,
              itemBuilder: (context, index) {
                final feeData =
                    feeStructure[index].data() as Map<String, dynamic>;

                return Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(16.0), // Add rounded corners
                    color: Colors.white, // Set background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBox,
                            FeeDetailRow(
                                title: 'Receipt No',
                                statusValue: '${feeData['receipt no']}'),
                            sizedBox,
                            FeeDetailRow(
                                title: 'Sem', statusValue: '${feeData['sem']}'),
                            sizedBox,
                            FeeDetailRow(
                                title: 'Due Date',
                                statusValue: '${feeData['due date']}'),
                            sizedBox,
                            FeeDetailRow(
                                title: 'Status',
                                statusValue: '${feeData['status']}'),
                            sizedBox,
                            FeeDetailRow(
                                title: 'Amount',
                                statusValue: '${feeData['amount']}'),
                            // Text('Sem: ${feeData['sem']}'),
                            // Text('Status: ${feeData['status']}'),
                            // Text('Amount: ${feeData['amount']}'),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                      ),
                      ListTile(
                        title: ElevatedButton(
                          onPressed: () {
                            // Add your payment logic here
                            // This is where you can handle the payment process
                            // For example, you can navigate to a payment screen
                            // or show a payment dialog.
                          },
                          child: const Text('Pay Amount'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
