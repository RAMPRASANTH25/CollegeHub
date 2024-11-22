import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_hub/chat_service.dart';
import 'package:college_hub/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  const ChatPage({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(children: [
        Expanded(
          child: _buildMessagelist(),
        ),
        _buildMessageInput()
      ]),
    );
  }

  Widget _buildMessagelist() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(
            data['message'],
          )
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            alignment: Alignment.center,
            controller: _messageController,
            hintText: 'Enter Message',
            obscureText: false,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
            size: 40,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
