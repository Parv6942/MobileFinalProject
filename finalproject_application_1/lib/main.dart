import 'package:finalproject_application_1/page/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MainApp());
}


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    home: HomeScreen(),
  );
  }
}

// Humza, the class contain the homescreen
// homescreen will display the menu with a image, title,
// and 3 buttons, start, leaderboard, exit
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      title:  const Center(
        child: Text("Rock Paper Scissor",
        style: TextStyle(fontWeight: FontWeight.bold,),
        textAlign: TextAlign.center,
        ),
      ),
      backgroundColor:  Colors.blueAccent,
    ),
    // the body that will contain the main image, and three buttons
    body: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        // Main Image with Border
        Container(
         decoration: BoxDecoration(
          border: Border.all(
          color: Colors.lightBlue.shade800,
          width: 5.0
          ),
         ),
         child:  Image.asset(
        "assets/main.jpg",
        height: 500,
        width: 700,
        fit: BoxFit.cover,
        ),
        ),
        
        // have a gap between the main image and the buttons
       SizedBox(height: 15),
       // house the three buttons (start, leaderboard, exit), use column to stack the buttons in a vertical format
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(onPressed: (){
             Navigator.push(context,
             MaterialPageRoute(builder: (context){
              return Player();
             })
             );
            }, child: Text("Start")),
            SizedBox(height: 10),
            FilledButton(onPressed: (){

            }, child: Text("Leaderboard")),
             SizedBox(height: 10),
             FilledButton(onPressed: (){
              SystemNavigator.pop(); // will exit, only works if you run on a phone emluator not chrome
             }, child: Text("Exit"))

          ],
        )

      ],
    ),
    ),
    );
  }
}