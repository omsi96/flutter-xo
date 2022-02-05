// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:x_o_game/models/room.dart';
import 'package:x_o_game/pages/signin.dart';
import 'package:x_o_game/pages/xo_game.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
      // TODO: UNUCOMMENT ME WHEN YOU ARRE DONE TESTING
      // home: XO_Game(
      //   mode: GameMode.networkPlayers,
      //   room: Room(owner: "Omar Alibrahim"),
      // ),
    );
  }
}
