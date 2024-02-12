import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/firebase/DBFirestore.dart';


class Auth extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
                  fontFamily: "Gilroy",
                ),
                decoration: InputDecoration(
                    hintText: "Email"
                ),
                onChanged: (text) {
                  email = text;
                },
              ),

              SizedBox(height: 20),

              TextField(
                style: TextStyle(
                  fontFamily: "Gilroy",
                ),
                decoration: InputDecoration(
                    hintText: "Password"
                ),
                onChanged: (text) {
                  password = text;
                },
              ),

              SizedBox(height: 40),

              ElevatedButton(
                  onPressed: ()  {
                    DBFirestore.auth(email, password, context);
                  },
                  child: Text("Войти")
              ),

              SizedBox(height: 20),

              ElevatedButton(
                  onPressed: ()  {
                    Navigator.pushNamed(context, "/registry");
                  },
                  child: Text("Регистрация")
              )
            ],
          ),
        ),
      )
    );
  }
}