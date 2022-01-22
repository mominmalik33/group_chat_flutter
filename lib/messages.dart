import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message_bubble.dart';

class Messages extends StatelessWidget {
  String name;
  Messages({this.name});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: ,
        builder:(ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection(name).orderBy('createdAt',descending: true).snapshots(),
            builder: (context,chatSnapshot) {
              if(chatSnapshot.connectionState == ConnectionState.waiting){
                return Center(
                    child: CircularProgressIndicator()
                );
              }
              final chatID = chatSnapshot.data.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatID.length,
                itemBuilder: (ctx,index) =>MessageBubble(
                  chatID[index]['text'],
                  chatID[index]['userId'] == FirebaseAuth.instance.currentUser.uid,
                  chatID[index]['name'].substring(0,chatID[index]['name'].indexOf('@')),
                  DateTime.parse(chatID[index]['createdAt'].toDate().toString()).toString()
                  // key: ValueKey(chatID[index].documentID),
                ),
              );
            },
          );
        }
    );
  }
}