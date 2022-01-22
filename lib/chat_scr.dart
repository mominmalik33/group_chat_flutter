import 'package:flutter/material.dart';
import 'package:discussion_board/messages.dart';
import 'package:discussion_board/new_messages.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({this.name});
  String name;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.orange,
        centerTitle: true,
        actions: [
          IconButton(
            icon:Icon(Icons.chat_bubble_outlined),
            onPressed: (){},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(name:widget.name),
            ),
            NewMessage(name: widget.name),
          ],
        ),
      ),
    );
  }
}
