import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitFormAuth(
      String email,
      String password,
      String userName,
      bool isLogIn,
      BuildContext ctx
      ) async
  {
    UserCredential authResult;
    try{
      setState(() {
        _isLoading = true;
      }
      );
      if(isLogIn){
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password
        );
      }
      else{
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password
        );
      }

      await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set(
          {
            'username':userName,
            'email':email,
          }
      );
    }
    on PlatformException catch(falut){
      var message = 'Error caught';
      if(falut.message!=null){
        message = falut.message;
      }
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,
          )
      );
      setState(() {
        _isLoading = false;
      });
    }
    catch(err){
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: AuthForm(_submitFormAuth,_isLoading),
    );
  }
}