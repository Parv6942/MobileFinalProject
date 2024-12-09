import 'package:flutter/material.dart';
import 'result.dart';


//Parv, Game screen class which starts after the text boxes in player.dart are filled in 
class GameScreen extends StatefulWidget {
  final String player1Name;
  final String player2Name;

  GameScreen({required this.player1Name, required this.player2Name});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  //Parv, player choices wait here
  String? player1Choice;
  String? player2Choice;


  //Parv, submit button function
  // it looks for if both players have made their choices and if they did then go on to the result screen.
  void submitChoices() {
    // this "if" statement determines if they have answered or not
    if (player1Choice == null || player2Choice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both players must select a choice!')),
      );
      return;
    }
      //Parv, this string is responsible for holding on to the winner name.
    String winner = Winner(player1Choice!, player2Choice!);

     // navigates to the result screen and gives all the juicy details as well 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          player1Name: widget.player1Name,
          player2Name: widget.player2Name,
          winner: winner,
        ),
      ),
    );
  }


  //winner logic, this determines how the players will win, if both players pick the same choice then it will be a draw, player 1 has 3 possible winnings,
  // if neither of them trigger then player 2 wins
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
            // P1 stuff
            Column(
              children: [
                Text(
                  "${widget.player1Name} Turn",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  // the rock paper scissors buttons
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

            // submit button
            ElevatedButton(
              onPressed: submitChoices,
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
            ),

            // P2 stuff
             Divider(height: 40),
            Text("${widget.player2Name} Turn"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // the rock paper scissors buttons again
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
