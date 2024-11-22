import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_hub/Dashboard/message/group_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:college_hub/Dashboard/message/chatpage.dart';
import 'package:college_hub/Dashboard/message/create_group.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Use 'Key?' instead of 'super.key'.

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void createGroup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const CreateGroup(
          // Pass the required membersList if needed
          membersList: [], // Add your list of members here
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const GroupChatHomeScreen();
                },
              )); // Call createGroup method
            },
            icon: const Icon(
              Icons.group,
              size: 25,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: _buildUserlist(),
    );
  }

  Widget _buildUserlist() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user')
          .where("role", isNotEqualTo: _auth.currentUser?.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child:
                  CircularProgressIndicator()); // Use a CircularProgressIndicator while loading
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['username'] ?? ""),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserEmail: data['email'],
                receiverUserId: document.id,
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
