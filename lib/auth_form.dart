import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFunc,this.isLoading);
  final void Function(String email,String password,String userName,bool isLogIn,BuildContext context) submitFunc;
  bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();

}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  var isLoggedIn = false;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState.save();
      widget.submitFunc(_userEmail.trim(),_userPassword.trim(),_userName.trim(),isLoggedIn,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white54,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('Email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Email Address',
                  ),

                  validator: (value){
                    if(value.isEmpty || !value.contains('@')){
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _userEmail = value;
                  },
                ),
                SizedBox(height: 20),
                if(!isLoggedIn)
                  TextFormField(
                    key: ValueKey('Name'),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'User Name',
                    ),
                    validator: (value){
                      if(value.isEmpty || value.length<4){
                        return 'Name should be greater than 3 letters';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userName = value;
                    },
                  ),
                SizedBox(height: 20),
                TextFormField(
                  key: ValueKey('Password'),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value){
                    if(value.isEmpty || value.length<7){
                      return 'Password should atleast contain 6 letters';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _userPassword = value;
                  },
                ),
                SizedBox(
                    height: 12
                ),
                if(widget.isLoading)
                  CircularProgressIndicator(),
                if(!widget.isLoading)
                  RaisedButton(
                      color: Colors.teal,
                      child: Text(isLoggedIn?'Login':'Signup'),
                      shape: StadiumBorder(),
                      onPressed: _trySubmit
                  ),
                if(!widget.isLoading)
                  FlatButton(
                      child: Text(isLoggedIn?'Register New Account':'I already have an account',
                        style: TextStyle(color: Colors.pink),
                      ),
                      onPressed: (){
                        setState(() {
                          isLoggedIn = !isLoggedIn;
                        }
                        );
                      }
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}