import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/classes/contact.dart';

class DBFirestore {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static void auth(String email, String password, BuildContext context) {
    firestore.collection("users").where("email", isEqualTo: email).get().then(
        (value) {
          if(value.docs.first.data()["password"] == password) {
            Navigator.popAndPushNamed(context, "/chats");
          } else {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
               content: Text(
                 "Неправильный пароль"
               ),
              );
            });
          }
        },
    ).onError((error, stackTrace) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(
            "Неправильный email"
          ),
        );
      });
        return null;
    });
  }

  static void registry(String email, String password, String name, String surname) {
    firestore.collection("users").doc().set({
      "name": name,
      "surname": surname,
      "email": email,
      "password": password
    });
  }

  static List<Contact> seachByName(String name) {
    List<Contact> contacts = [];
    firestore.collection("users").where("name", isEqualTo: name).get().then(
        (values) {
          print("Nice");
          for (var value in values.docs) {
            contacts.add(Contact(value["name"], value["surname"]));
            print(value.data());
          }
        });
    return contacts;
  }

}
