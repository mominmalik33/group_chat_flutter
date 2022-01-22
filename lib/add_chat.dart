import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddChat extends StatefulWidget {
  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  final _formKey = GlobalKey<FormState>();
  String _groupName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[400],
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  cursorColor: Colors.lightBlue,
                  decoration: InputDecoration(
                    hintText: 'Add Talk',
                    prefixIcon: Icon(Icons.add_circle_outline,color: Colors.lightBlue),
                    hintStyle: TextStyle(color: Colors.lightBlue,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                  onSaved: (value){
                    _groupName = value;
                  },
                ),
                SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Add',style: TextStyle(fontSize: 20,color: Colors.white)),
                      ),
                      elevation: 0,
                      color: Colors.green,
                      onPressed: () async{
                        _formKey.currentState.save();
                        await FirebaseFirestore.instance.collection('groups').add(
                            {
                              'name':_groupName
                            }
                        );
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Cancel',style: TextStyle(fontSize: 20,color: Colors.white)),
                      ),
                      color: Colors.redAccent,
                      elevation: 0,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.exit_to_app,size: 50,),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}