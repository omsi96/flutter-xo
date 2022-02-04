import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:x_o_game/models/room.dart';

Future<Room> createRoom() async {
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  // Authorization
  if (FirebaseAuth.instance.currentUser?.uid == null) {
    throw ErrorDescription("You are not authorized to perform this action!");
  }
  final owner = FirebaseAuth.instance.currentUser!.uid;
  final room = Room(owner: owner);
  final createdRoom = await rooms.add(room.toJson());
  room.id = createdRoom.id;

  return room;
}

Stream<List<Room>> fetchRooms() {
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  return rooms.snapshots(includeMetadataChanges: true).map(
        (snapshot) => snapshot.docs
            .map((doc) => Room.fromJson(doc.data(), doc.id))
            .toList(),
      );
}

void enterRoom(String roomId) async {}
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

void play() async {}

Stream<Map<String, dynamic>> listenRoom(String roomId) {
  return FirebaseFirestore.instance
      .collection("rooms")
      .doc(roomId)
      .snapshots(includeMetadataChanges: true)
      .map((snapshot) => snapshot.data()!["grid"]!);
}
