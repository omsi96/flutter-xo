import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'room.g.dart';

@JsonSerializable()
class Room {
  String owner;
  String? opponent;
  int turn = 0;
  bool openRoom = false;
  bool gameOver = false;
  int ownerWins = 0;
  int opponentWins = 0;
  String? id;
  List<String> grid = ["", "", "", "", "", "", "", "", ""];
  // 1st constructor
  // Use this contrusctor if you (as a develoepr) want to create a new room
  Room({required this.owner});

  // 2nd construuctor
  // Use this contructor to decode a recieved room from network.
  factory Room.fromJson(Object? data, String id) {
    final json = data is Map<String, dynamic> ? data : null;
    if (json == null) {
      print("Couldn't serizlie objec null");
      throw ErrorDescription("Couldn't serialize object of null");
    }
    return _$RoomFromJson(json)..id = id;
  }
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
