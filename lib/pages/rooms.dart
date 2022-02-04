import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import "package:x_o_game/apis/firebase.game.dart" as game;
import 'package:x_o_game/pages/xo_game.dart';

class Rooms extends StatefulWidget {
  Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  List<String> _rooms = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchRooms();
  // }

  // void fetchRooms() async {
  //   final fetchedRooms = await game.fetchRooms();
  //   setState(() {
  //     _rooms = fetchedRooms;
  //   });
  // }

  void createRoom() async {
    final roomId = await game.createRoom();
    navigateToRoom(roomId);
    // setState(() {
    //   _rooms.insert(0, roomId);
    // });
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void navigateToRoom(String roomId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => XO_Game(
            mode: GameMode.networkPlayers,
            roomId: roomId,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rooms")),
      floatingActionButton: FloatingActionButton(
        onPressed: createRoom,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: game.fetchRooms(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text("ERROR");
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Text("Loading");

          var rooms = snapshot.data as List<String>;
          print("#$rooms");

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(rooms[index].substring(0, 4)),
              onTap: () => navigateToRoom(rooms[index]),
            ),
          );
        },
      ),
    );
  }
}
