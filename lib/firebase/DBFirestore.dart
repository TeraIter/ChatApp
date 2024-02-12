import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/classes/Contact.dart';

class DBFirestore {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static void auth(String email, String password, BuildContext context) {
    firestore.collection("users").where("email", isEqualTo: email).get().then(
        (value) {
          if(value.docs.first.data()["password"] == password) {
            Navigator.popAndPushNamed(context, "/chats",arguments: value.docs.first.id);
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

  static Future<List<Contact>> searchByName(String name) async {
    List<Contact> contacts = [];

    await firestore.collection("users").where("name", isEqualTo: name).get().then(
        (values) {
          for (var value in values.docs) {
            contacts.add(Contact(value["name"], value["surname"]));
          }
        });

    return contacts;
  }

  static Future<List<Contact>> getContacts(String id) async {
    List<Contact> contacts = [];
    List contactsId = [];

    await firestore.collection("users").doc(id).get().then(
            (value) {
              var chats = value["chats"];
              print("Chats is: $chats");
              for (var map in chats) {
                print("Map is: $map");
                contactsId.add(map["memberId"]);
              }
            }
    );

    for (String id in contactsId) {
      await firestore.collection("users").where(FieldPath.documentId, isEqualTo: id).get().then(
              (value) {
                contacts.add(Contact(value.docs.first["name"], value.docs.first["surname"]));
              },
        onError: (e) {

        }
      );
    }
    return contacts;
  }

  static void changeIsOnline(String id, bool flag) {
    firestore.collection("users").doc(id).update({
      "isOnline": flag
    });
  }

}
