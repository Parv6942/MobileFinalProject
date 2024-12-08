import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  final String playerOneName;
  final String playerTwoName;

  Leaderboard({required this.playerOneName, required this.playerTwoName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Player 1: $playerOneName"),
            Text("WIN?LOSE?TIE"),
            Text("Player 2: $playerTwoName"),
          ],
        ),
      ),
    );
  }
}
