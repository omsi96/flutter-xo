// ignore_for_file: unused_field, prefer_const_constructors_in_immutables, prefer_final_fields, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_o_game/pages/home.dart';
import 'package:x_o_game/pages/rooms.dart';
import 'package:x_o_game/pages/signup.dart';
import "package:x_o_game/apis/firebase.auth.dart" as auth;

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _emailField = TextEditingController(text: "");
  var _passwordField = TextEditingController(text: "");

  void signIn() {
    auth.signIn(_emailField.text, _passwordField.text, () {
      navigateToHome();
    });
  }

  void navigateToHome() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => Rooms()));
  }

  void navigateToSignUp() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              CupertinoTextField(
                controller: _emailField,
                placeholder: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              CupertinoTextField(
                controller: _passwordField,
                placeholder: "Password",
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: signIn, child: Text("Sign In")),
              TextButton(
                  onPressed: () => navigateToSignUp(),
                  child: Text("Create account")),
            ],
          ),
        ));
  }
}
