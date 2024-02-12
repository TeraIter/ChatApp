import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/firebase/DBFirestore.dart';

class Registry extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: registryForm(context),
    );
  }
}

Widget registryForm(BuildContext context) {
  String email = "", password = "", surname = "", name = "";

  return Center(
    child: Container(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Имя"
            ),
            style: TextStyle(
              fontFamily: "Gilroy"
            ),
            onChanged: (text) {
              name = text;
            },
          ),

          SizedBox(height: 20),

          TextField(
              decoration: InputDecoration(
                  hintText: "Фамилия"
              ),
              style: TextStyle(
                  fontFamily: "Gilroy"
              ),
            onChanged: (text) {
              surname = text;
            },
          ),

          SizedBox(height: 20),

          TextField(
              decoration: InputDecoration(
                  hintText: "Email"
              ),
              style: TextStyle(
                  fontFamily: "Gilroy"
              ),
            onChanged: (text) {
              email = text;
            },
          ),

          SizedBox(height: 20),

          TextField(
              decoration: InputDecoration(
                  hintText: "Пароль"
              ),
              style: TextStyle(
                  fontFamily: "Gilroy"
              ),
            onChanged: (text) {
              password = text;
            },
          ),

          SizedBox(height: 40),

          ElevatedButton(
              onPressed: () {
                DBFirestore.registry(email, password, name, surname);

                Navigator.pop(context);

                showDialog(context: context, builder: (context) {
                  return AlertDialog(title: Text(
                      "Успешно добавлен"
                  ),
                  );
                });

              },
              child: Text(
                "Ок"
              )
          )
        ],
      ),
    ),
  );
}