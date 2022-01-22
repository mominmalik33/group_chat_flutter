import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message,this.isMe,this.userData,this.time,{this.key});
  final String userData;
  final String time;
  final String message;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe?Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: !isMe ? Radius.circular(0):Radius.circular(12),
                    bottomRight: isMe ? Radius.circular(0):Radius.circular(12)
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              width: 140,
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(color:isMe?Colors.black: Theme.of(context).accentTextTheme.title.color),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8.0),
          child: Text(userData,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8.0),
          child: Text("Sent at"+time,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: Colors.black54)),
        ),
      ],
      // overflow: Overflow.visible,
    );
  }
}