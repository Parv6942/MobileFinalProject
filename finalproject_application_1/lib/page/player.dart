// Import to detect if the application is running on the web platform
import 'package:finalproject_application_1/page/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Import to use Flutter's core framework and material design widgets
import 'package:flutter/material.dart';

// Import to access and control the device camera
import 'package:camera/camera.dart';

// Import to access commonly used locations on device's file system
import 'package:path_provider/path_provider.dart';

// Import for file operations, sockets, HTTP, and other I/O-related tasks (for mobile platforms)
import 'dart:io';

// Import for handling binary data efficiently 
import 'dart:typed_data'; 

// Import for platform-specific services and interaction with native code
import 'package:flutter/services.dart';


// Humza Sheikh,
// contains Player class that defines the player widget as a statefulwidget,
//  it is required to maintain the state when player widget is changing 
class Player extends StatefulWidget {
@override 
_PlayerState createState() => _PlayerState();

}

// Humza Sheikh,
// class house the functions to make the camera feature to work (Make sure to allow your device to accept the camera and microphone, this required to make the camera function to work)
// house the textbox for user to enter their name
class _PlayerState extends State<Player>{
CameraController?_cameraController; // Controller to interact with the camera
XFile? _imageFile1; // Variable to store the image for player 1
XFile? _imageFile2; // Variable to store the image for player 2
Uint8List? _imageBytes1; // Bytes of the image for web usage (Player 1)
Uint8List? _imageBytes2; // Bytes of the image for web usage (Player 2)

// add two controllers for the two text fields
final TextEditingController playerOneController = TextEditingController();
final TextEditingController playerTwoController = TextEditingController();


@override
  void initState(){
    super.initState();
    _initializeCamera(); // Initialize the camera when the widget is created
  }

Future<void> _initializeCamera() async{
  // Get the list of available cameras
  final cameras = await availableCameras();
  if(cameras.isNotEmpty){
    // Initialize the camera controller with the first available camera
 _cameraController = CameraController(cameras[0], ResolutionPreset.high);
await _cameraController!.initialize(); // Wait for the controller to finish initializing 
setState(() {}); // Update the UI to reflect the camera initialization 
  }
}

Future<void> _takePicture(int player) async{
  // Check the camera controller is initialized
  if(_cameraController == null || !_cameraController!.value.isInitialized) return;

  try {
    // Capture the image 
       final XFile image = await _cameraController!.takePicture();

        if(kIsWeb){
          // Handle web-specific image storage
          final bytes = await image.readAsBytes();
          setState(() {
        // Store the image path in the appropriate variable based on the player
        if(player ==1 ){
         _imageFile1 =  image;
         _imageBytes1 = bytes;
        }else{
          _imageFile2 = image;
          _imageBytes2= bytes;
        }
      });
        }
        else{
          // Handle image storage on mobile 
          final directory = await getApplicationCacheDirectory(); // Get the cache directory for the application
          final imagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png'; // Create a unique file path for the image using the current timestamp
          await image.saveTo(imagePath); // Save the captured image to the specified file path 
          setState(() {
            // Store the image in the appropriate variable based on the player 
            if (player == 1){
              _imageFile1 = XFile(imagePath);
            }
            else {
              _imageFile2 = XFile(imagePath);
            }
          });
        }
  } catch (e){
    print("Error: $e"); // Print any errors that occur during image capture
  }
}

@override
void dispose(){
  _cameraController?.dispose(); // Dispose of the camera controller when the widget is removed
  super.dispose();
}

@override
 Widget build(BuildContext context){
  // Show a loading indicator while the camera is initializing 
  if(_cameraController == null || !_cameraController!.value.isInitialized){
  return Scaffold(
   appBar: AppBar(
    title: Text("Game Screen"),
    backgroundColor: Colors.blueAccent,
   ),
   body: Center(child: CircularProgressIndicator()),
   );
  }

  // Build the UI for the Player screen 
  return Scaffold(
appBar: AppBar(
  title: Text("Game Screen"),
  backgroundColor: Colors.blueAccent,
),
body: Center(
  child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
  // Player 1

  // Check if Player 1's image file is null
  // If null, display a message saying "No image selected."
  // If not null, display the image
  Text("Player 1"), _imageFile1 == null ? 
  Text("No image selected.") : 
  // KIsWeb is Display image for web
  (kIsWeb ? Image.memory(_imageBytes1!,  // Image bytes for player 1
  width: 200,  // Set width of the image
  height:  200,)  // Set height of the image 
  // Display image for mobile 
  : Image.file(File(_imageFile1!.path), // Image file for player 1
     width: 200, // Set width of the image
     height: 200, // Set height of the  image
     )), 
  SizedBox(height: 5),  // add some space

  // Button to take a photo for player 1
  FilledButton(onPressed: () => _takePicture(1), 
  child: Text("Take Photo for Player 1"),
  ),

  // add some space
  SizedBox(height: 5),

  // Container for the TextFiled for player 1's username
   Container(
    width: 400, // Set the width of the container
    height: 100, // Set the height of the container 
    child: TextField(controller: playerOneController, // Controller for player 1's username
    decoration: InputDecoration(
    border: OutlineInputBorder(), // outline border for the TestField
    labelText: 'Enter Username',  // Lable text for the TextField
    ),
  ),
),
 ///Add space between the two players

  // Player 2
  // Check if Player 2's image file is null
  // If null, display a message saying "No image selected."
  // If not null, display the image
  Text("Player 2"),
  _imageFile2 == null ? 
  Text("No image selected.") : 
  // KIsWeb is Display image for web
  (kIsWeb ?
   Image.memory(_imageBytes2!, // Image bytes for player 2
   width: 200, // Set width of the image
   height: 200,) // Set height of the image
  // Display image for mobile
   : Image.file(File(_imageFile2!.path),
      height: 200,  // Set height of the image
      width: 200,)  // Set width of the image
   ),
    SizedBox( height: 5), // add some space 

     // Button to take a photo for player 2
    FilledButton(onPressed: () => _takePicture(2), 
    child: Text("Take Photo for Player 2"),
    ),

    // add some space
  SizedBox(height: 5),

  // Container for the TextField for Player 2's username
   Container(
    width: 400, // set the width of the container
    height: 100, // set the height of the container
    child: TextField(controller: playerTwoController, // Controller of Player 2's username
    decoration: InputDecoration(
    border: OutlineInputBorder(),  // Outline border for the TextField
    labelText: 'Enter Username',
    ),
  ),
), // connect the textfield to the playertwoController

FilledButton(
  onPressed: () {
    if (playerOneController.text.isEmpty || playerTwoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both player names!")),
      );
      return;
    }

   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => GameScreen(
          player1Name: playerOneController.text,
          player2Name: playerTwoController.text,
        ),
      ),
    );
  },
  child: Text("Start Game"),
),
],
  ),
),
  );
 }
}