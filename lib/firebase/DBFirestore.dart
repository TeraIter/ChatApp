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
            contacts.add(Contact(value.id ,value["name"], value["surname"]));
          }
        });

    return contacts;
  }

  static Future<List<Map>> getChats(String id) async {
    List<Map> chats = [];
    List<String> memberId = [];
    List<String> chatId = [];


    await firestore.collection("users").doc(id).get().then(
            (value) {
              try {
                var chats = value["chats"];
                for (var map in chats) {
                  memberId.add(map["memberId"]);
                  chatId.add(map["chatId"]);
                }
              } catch(e) {}
            }
    );

    for (int i = 0; i < memberId.length; i++) {
      await firestore.collection("users").where(FieldPath.documentId, isEqualTo: memberId[i]).get().then(
              (value) {
                chats.add({
                  "contact": Contact(memberId[i], value.docs.first["name"], value.docs.first["surname"]),
                  "chatId": chatId[i]
                });

              },
        onError: (e) {}
      );
    }
    return chats;
  }

  static void changeIsOnline(String id, bool flag) {
    firestore.collection("users").doc(id).update({
      "isOnline": flag
    });
  }

  static Future<void> beginChat(String currentMemberId, String memberId) async {
    var count = await firestore.collection("counters").doc("chats").get();

    await firestore.collection("counters").doc("chats").update({
      "count": FieldValue.increment(1)
    });

    await firestore.collection("users").doc(currentMemberId).update({
      "chats": FieldValue.arrayUnion([
        {
          "chatId": count["count"],
          "memberId": memberId
        }
      ])
    });

    var ref = FirebaseDatabase.instance.ref();
    await ref.child("chats").update({
      "${count["count"]}": {
        "messages": {
          "count": 0
        },}
    });
  }

}
