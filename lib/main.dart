import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_project/firebase/DBFirestore.dart';
import 'package:new_project/firebase_options.dart';
import 'package:new_project/screens/Auth.dart';
import 'package:new_project/screens/Chat.dart';
import 'package:new_project/screens/Chats.dart';
import 'package:new_project/screens/Registry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "New Project",

      routes: {
        "/": (context) => Auth(),
        "/chats": (context) => Chats(),
        "/registry": (context) => Registry(),
      },
    );
  }

}




