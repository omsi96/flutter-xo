import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import "package:x_o_game/apis/firebase.game.dart" as game;
import 'package:x_o_game/models/room.dart';
import 'package:x_o_game/pages/xo_game.dart';

class Rooms extends StatefulWidget {
  Rooms({Key? key}) : super(key: key);

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  List<String> _rooms = [];
  void createRoom() async {
    final room = await game.createRoom();
    navigateToRoom(room);
  }

  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void navigateToRoom(Room room) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => XO_Game(
            mode: GameMode.networkPlayers,
            room: room,
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

          var rooms = snapshot.data as List<Room>;
          print("#$rooms");

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) => ListTile(
              title: Text((rooms[index].id?.substring(0, 4) ?? "NO ROOM ID")),
              onTap: () => navigateToRoom(rooms[index]),
            ),
          );
        },
      ),
    );
  }
}
