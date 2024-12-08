import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String player1Name;
  final String player2Name;
  final String winner;

  ResultScreen({
    required this.player1Name,
    required this.player2Name,
    required this.winner,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              winner,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("Restart"),
            ),
            ElevatedButton(
              onPressed: () {
                // Wills leaderboard button
              },
              child: Text("Leaderboard"),
            ),
          ],
        ),
      ),
    );
  }
}
