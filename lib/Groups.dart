import 'package:discussion_board/chat_scr.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder:(ctx,futureSnapshot){
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('groups').snapshots(),
            builder: (context,groupSnapshot) {
              if(groupSnapshot.connectionState == ConnectionState.waiting){
                return Center(
                    child: CircularProgressIndicator()
                );
              }
              final groupData = groupSnapshot.data.docs;
              return ListView.builder(
                itemCount: groupData.length,
                itemBuilder: (ctx,index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10.0),
                  child: ListTile(
                    leading: Image.asset('assets/message.png'),
                    title: Text(groupData[index]['name']),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(name:groupData[index]['name'])),
                      );
                    },
                  ),
                )
              );
            },
          );
        }
    );
  }
}