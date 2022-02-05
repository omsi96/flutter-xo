import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:x_o_game/models/room.dart';

class RoomStream {
  RoomStream({
    required this.roomStream,
    required this.roomId,
  });
  Stream<Room> roomStream;
  String roomId;
}

Future<RoomStream> createRoom() async {
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  // Authorization
  if (FirebaseAuth.instance.currentUser?.uid == null) {
    throw ErrorDescription("You are not authorized to perform this action!");
  }
  final owner = FirebaseAuth.instance.currentUser!.uid;
  final room = Room(owner: owner);
  final roomRef = await rooms.add(room.toJson());

  final roomStream = roomRef
      .snapshots(includeMetadataChanges: true)
      .map((event) => Room.fromJson(event.data(), event.id));
  return RoomStream(roomStream: roomStream, roomId: roomRef.id);
  // return room;
}

Stream<List<Room>> fetchRooms() {
  CollectionReference roomsRef = FirebaseFirestore.instance.collection('rooms');
  var roomStream = roomsRef.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => Room.fromJson(doc.data(), doc.id))
            .toList(),
      );
  return roomStream;
}

Future<Room> fetchRoom(String roomId) async {
  final userId = authenticate();
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc(roomId);
  final room = Room.fromJson((await roomRef.get()).data(), roomId);
  return room;
}

Future updateRoom(Room room) async {
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc(room.id);
  await roomRef.set(room.toJson());
}

Future<Stream<Room>> enterRoom(String roomId) async {
  final userId = authenticate();
  // To enter room, that means we are either opponent or owwner
  // If we are owners, that should not change anything, because an owener cannot play with the himself.
  // Opponent will update the value of room.opponent to his uid (in future his user object)
  // Opponent will update the valuue of room.isOpen to true after it checkes both opponent and owner are there
  final room = await fetchRoom(roomId);
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc(room.id);

  room.opponent = userId;
  room.openRoom = true;
  await updateRoom(room);
  final stream = roomRef
      .snapshots(includeMetadataChanges: true)
      .map((event) => Room.fromJson(event.data(), event.id));
  return stream;
}

void leaveRoom(String roomId) async {}

String? authenticate() {
  // Authentication
  if (FirebaseAuth.instance.currentUser?.uid == null) {
    throw ErrorDescription("You are not authorized to perform this action!");
  }
  return FirebaseAuth.instance.currentUser?.uid;
}

Future<bool> isRoomOwner(String roomId) async {
  final userId = authenticate();
  if (userId == null) return false;

  // Authorizing
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc(roomId);
  final roomJSON = (await roomRef.get()).data();
  if (roomJSON == null) return false;
  final room = Room.fromJson(roomJSON, roomId);
  return room.owner == userId;
}

void terminateRoom(String roomId) async {
  if (!(await isRoomOwner(roomId))) {
    throw ErrorDescription("You are not authorized!");
  }
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc(roomId);
  await roomRef.delete();
}

void play({required List<String> grid, required String roomId}) async {
  final userId = authenticate();
  if (userId == null) return;
  final roomRef = FirebaseFirestore.instance.collection("rooms").doc(roomId);
  final roomJSON = (await roomRef.get()).data();
  if (roomJSON == null) return;
  final room = Room.fromJson(roomJSON, roomId);
  room.grid = grid;
  await updateRoom(room);
}

Stream<Map<String, dynamic>> listenRoom(String roomId) {
  return FirebaseFirestore.instance
      .collection("rooms")
      .doc(roomId)
      .snapshots(includeMetadataChanges: true)
      .map((snapshot) => snapshot.data()!["grid"]!);
}
