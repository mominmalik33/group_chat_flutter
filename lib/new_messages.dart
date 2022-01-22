import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class NewMessage extends StatefulWidget {
  String name;
  NewMessage({this.name});
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _message = '';
  final _controller = new TextEditingController();

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection(widget.name).add(
        {
          'name':FirebaseAuth.instance.currentUser.email,
          'text':_message,
          'createdAt':Timestamp.now(),
          'userId':user.uid,
        }
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: 'Post your message......'
                ),
                onChanged: (value){
                  setState(() {
                    _message = value;
                  });
                },
              )
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.orange,
            ),
            onPressed: _message.trim().isEmpty?null:_sendMessage,
          ),
        ],
      ),
    );
  }
}