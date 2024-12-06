import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
//import 'package:path_provider/path_provider.dart'; 
//import 'dart:io';

class Player extends StatefulWidget {
@override 
_PlayerState createState() => _PlayerState();

}

class _PlayerState extends State<Player>{
CameraController?_cameraController; // Controller for the camera
XFile? _imageFile1; // Variable to store the image for player 1
XFile? _imageFile2; // Variable to store the image for player 2

@override
  void initState(){
    super.initState();
    _initializeCamera(); // Initialize the camera when the widget is created
  }

Future<void> _initializeCamera() async{
  // Get the list of available cameras
  final cameras = await availableCameras();
  if(cameras.isNotEmpty){
    
  }
}

@override
 Widget build(BuildContext context){
  return Scaffold(

  );
 }
}