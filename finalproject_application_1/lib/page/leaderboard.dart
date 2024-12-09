import 'package:flutter/material.dart';

import 'globals.dart' as globals; 

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: ListView.builder(
        itemCount: globals.gameResults.length,
        itemBuilder: (context, index) {
          var result = globals.gameResults[index];
          return ListTile(
            title: Text('${result['player1']} vs ${result['player2']}'),
            subtitle: Text('Winner: ${result['winner']}'),
          );
        },
      ),
    );
  }
}