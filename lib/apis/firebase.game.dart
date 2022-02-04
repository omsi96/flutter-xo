import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String> createRoom() async {
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  // Authorization
  if (FirebaseAuth.instance.currentUser?.uid == null) {
    return Future.error(
        ErrorDescription("You are not authorized to perform this action!"));
  }

  // Call the user's CollectionReference to add a new user
  final room = await rooms.add({
    'owner': FirebaseAuth.instance.currentUser!.uid,
  });
  return room.id;
}

Stream<List<String>> fetchRooms() {
  CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');
  return rooms
      .snapshots(includeMetadataChanges: true)
      .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
}

void enterRoom(String roomId) async {}

void terminateRoom(String roomId) async {
  if (FirebaseAuth.instance.currentUser?.uid == null) {
    return Future.error(
        ErrorDescription("You are not authorized to perform this action!"));
  }
  print("#### TRYING TO DELETE ROOM $roomId");
  final room = FirebaseFirestore.instance.collection("rooms").doc(roomId);

  final roomObject = await room.get();
  final roomMap = roomObject.data();
  if (roomMap == null) return;
  if (roomMap["owner"]! == FirebaseAuth.instance.currentUser!.uid) {
    print(
        "**** The owner of the room is ${roomMap["owner"]}, and you are ${FirebaseAuth.instance.currentUser!.uid}");
    // I am the owneer of this room
    await room.delete();
  } else {
    print("You can't delete your partenrs room");
  }
}

void play() async {}

Stream<Map<String, dynamic>> listenRoom(String roomId) {
  return FirebaseFirestore.instance
      .collection("rooms")
      .doc(roomId)
      .snapshots(includeMetadataChanges: true)
      .map((snapshot) => snapshot.data()!["grid"]!);
}
