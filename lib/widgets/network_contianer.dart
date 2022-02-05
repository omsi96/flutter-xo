// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:x_o_game/models/room.dart';

class NetworkPlayersContainer extends StatefulWidget {
  Room room;
  NetworkPlayersContainer(this.room, {Key? key}) : super(key: key);

  @override
  State<NetworkPlayersContainer> createState() =>
      _NetworkPlayersContainerState();
}

class _NetworkPlayersContainerState extends State<NetworkPlayersContainer> {
  @override
  Widget build(BuildContext context) {
    final waitingMessage = "Waiting for a player to join";

    return Column(
      children: [
        Text(
          widget.room.openRoom ? "" : waitingMessage,
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              _PlayerLabel(widget: widget, title: "You"),
              _PlayerLabel(widget: widget, title: "Opponent"),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayerLabel extends StatelessWidget {
  const _PlayerLabel({
    Key? key,
    required this.widget,
    required this.title,
  }) : super(key: key);

  final NetworkPlayersContainer widget;
  final String title;

  @override
  Widget build(BuildContext context) {
    final player =
        title == "You" ? widget.room.owner : widget.room.opponent ?? "Guest";
    final score =
        title == "You" ? widget.room.ownerWins : widget.room.opponentWins;
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "$score",
                  style: TextStyle(fontSize: 25),
                )),
            Text(
              player,
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            // Text(title),
          ],
        ),
      ),
    );
  }
}
