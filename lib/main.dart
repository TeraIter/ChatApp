import 'package:flutter/material.dart';
import 'package:new_project/screens/Chats.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "New Project",
      home: Chats(),
    );
  }
}