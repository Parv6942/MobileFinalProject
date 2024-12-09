import 'package:flutter/material.dart';
import 'result.dart';

class GameScreen extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  final List<Map<String, String>> gameResults;

  GameScreen({required this.player1Name, required this.player2Name, required this.gameResults});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String? player1Choice;
  String? player2Choice;

  void submitChoices() {
    if (player1Choice == null || player2Choice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both players must select a choice!')),
      );
      return;
    }

    String winner = Winner(player1Choice!, player2Choice!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          player1Name: widget.player1Name,
          player2Name: widget.player2Name,
          winner: winner,
          gameResults: widget.gameResults,
        ),
      ),
    );
  }


  //winner decider
  String Winner(String p1, String p2) {
    if (p1 == p2) return "It's a Tie!";
    if ((p1 == "Rock" && p2 == "Scissors") ||
        (p1 == "Paper" && p2 == "Rock") ||
        (p1 == "Scissors" && p2 == "Paper")) {
      return "${widget.player1Name} Wins!";
    }
    return "${widget.player2Name} Wins!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rock Paper Scissors"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // P1
            Column(
              children: [
                Text(
                  "${widget.player1Name} Turn",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["Rock", "Paper", "Scissors"]
                      .map((choice) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  player1Choice = choice;
                                });
                              },
                              child: Text(choice),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),

            // submit 
            ElevatedButton(
              onPressed: submitChoices,
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),

            // P2
             Divider(height: 40),
            Text("${widget.player2Name} Turn"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ["Rock", "Paper", "Scissors"]
                  .map((choice) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              player2Choice = choice;
                            });
                          },
                          child: Text(choice),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
