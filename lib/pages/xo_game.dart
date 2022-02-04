// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_o_game/utils/winning_situations.dart';
import "package:x_o_game/apis/firebase.game.dart" as game;

class GameMode {
  static String onePlayer = "One Player";
  static String twoPlayers = "Two Players";
  static String networkPlayers = "Network Players";
}

class XO_Game extends StatefulWidget {
  XO_Game({Key? key, required this.mode, this.roomId}) : super(key: key);
  String mode;
  String? roomId;

  void prepareNetowrkPlayers() {
    // if (mode == GameMode.networkPlayers) {
    //   if (roomId != null) {
    //     var stream = game.listenRoom(roomId!);
    //     stream.
    //   } else {
    //     print("Too shame, no document id?");
    //   }
    // }
  }

  @override
  State<XO_Game> createState() => _XO_GameState();
}

class _XO_GameState extends State<XO_Game> {
  // int _counter = 0;
  String gameLabel = "X turn";
  bool gameOver = false;
  final _computerDelay = 700;
  String _currentPlayer = "X";
  // ignore: prefer_final_fields
  var _grid = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
  ];

  var buttonStyle = GoogleFonts.quicksand(
    textStyle: TextStyle(
        color: Colors.blue,
        letterSpacing: .5,
        fontSize: 48,
        fontWeight: FontWeight.w700),
  );

  void pressButton(int r, int c) {
    if (gameOver) return; // Guards the function
    if (!playerReady()) return;

    userTurn(r, c);
    if (gameOver) return; // Guards the function
    computerTurn();
  }

  void computerTurn() {
    if (widget.mode == GameMode.onePlayer) {
      Future.delayed(Duration(milliseconds: _computerDelay), () {
        if (randomEmptySpot().isNotEmpty) {
          final randomSpot = randomEmptySpot();
          int r = randomSpot[0];
          int c = randomSpot[1];
          setState(() {
            _grid[r][c] = "O";
            displayMessage(_currentPlayer);
            togglePlayer();
          });
        }
      });
    }
  }

  void togglePlayer() {
    setState(() {
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
    });
  }

  bool playerReady() =>
      _currentPlayer == "X" || widget.mode != GameMode.onePlayer;

  void userTurn(int r, int c) {
    if (_grid[r][c] != "") {
      showNotAllowedAreaAlert();
      return;
    }
    setState(() {
      _grid[r][c] = _currentPlayer;
      displayMessage(_currentPlayer);
      togglePlayer();
    });
  }

  String apponentPlayer() {
    return _currentPlayer == "X" ? "O" : "X";
  }

  void showNotAllowedAreaAlert() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Cannot replace other player")));
  }

  void displayMessage(currentPlayer) {
    setState(() {
      gameLabel = "${apponentPlayer()} turn";
      if (checkWinner(currentPlayer).isNotEmpty) {
        gameLabel = "${currentPlayer} wins!";
        gameOver = true;
      }
    });
  }

  String checkWinner(String player) {
    for (var winningArray in XO_Utils.winningSituations) {
      if (winningArray
              .map((indexes) => _grid[indexes[0]][indexes[1]])
              .join("") ==
          "$player$player$player") return player;
    }
    return "";
  }

  void restartGame() {
    setState(() {
      _currentPlayer = "X";
      gameLabel = "X turn";
      gameOver = false;
      // ignore: prefer_final_fields
      _grid = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""],
      ];
    });
  }

  List<int> randomEmptySpot() {
    List<List<int>> emptyIndexs = [];
    for (var r = 0; r < 3; r++) {
      for (var c = 0; c < 3; c++) {
        if (_grid[r][c] == "") {
          emptyIndexs.add([r, c]);
        }
      }
    }
    if (emptyIndexs.isNotEmpty) {
      return emptyIndexs[Random().nextInt(emptyIndexs.length)];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gameLabel,
              style: Theme.of(context).textTheme.headline3,
            ),
            for (int r = 0; r < 3; r++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int c = 0; c < 3; c++)
                    GestureDetector(
                      onTap: () => pressButton(r, c),
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(_grid[r][c], style: buttonStyle)),
                    ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: restartGame, child: Text("Restart"))
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // super.deactivate();
    print("%%%%% WE'RE inside XO game. Trying to remove ${widget.roomId}");
    final roomId = widget.roomId;
    if (roomId == null) return;
    game.terminateRoom(roomId);
  }
}
