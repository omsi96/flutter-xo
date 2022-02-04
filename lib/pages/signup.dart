// ignore_for_file: unused_field, prefer_const_constructors_in_immutables, prefer_final_fields, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:x_o_game/pages/home.dart';
import "package:x_o_game/apis/firebase.auth.dart" as auth;
import 'package:x_o_game/pages/rooms.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _emailField = TextEditingController(text: "");
  var _passwordField = TextEditingController(text: "");
  var _nameField = TextEditingController(text: "");

  void register() {
    auth.register(
        name: _nameField.text,
        email: _emailField.text,
        password: _passwordField.text,
        success: () => navigateToHome());
  }

  void navigateToHome() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => Rooms()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up")),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              CupertinoTextField(
                controller: _nameField,
                placeholder: "Full Name",
                keyboardType: TextInputType.name,
              ),
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
              ElevatedButton(onPressed: register, child: Text("Sign Up")),
            ],
          ),
        ));
  }
}
