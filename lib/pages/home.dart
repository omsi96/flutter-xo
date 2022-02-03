import 'package:flutter/material.dart';
import 'package:x_o_game/pages/xo_game.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => XO_Game(mode: GameMode.onePlayer),
                      ));
                },
                child: Text("One Players")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            XO_Game(mode: GameMode.twoPlayers),
                      ));
                },
                child: Text("Two Players")),
          ],
        ),
      ),
    );
  }
}
