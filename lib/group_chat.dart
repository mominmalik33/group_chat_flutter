import 'package:discussion_board/Groups.dart';
import 'package:discussion_board/add_chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupChat extends StatefulWidget {
  @override
  _GroupChatState createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Discussion Board"),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: (){
                showModalBottomSheet(context: context, builder: (context) => AddChat());
              }
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: (){
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
      body: Groups(),
    );
  }
}
