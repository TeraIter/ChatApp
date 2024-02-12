import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/firebase/DBFirestore.dart';

import '../../classes/Contact.dart';

class NewContacts extends StatefulWidget {
  var state = _NewContactsState();

  @override
  _NewContactsState createState() => state;
}

class _NewContactsState extends State<NewContacts> {
  String text = "";
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBFirestore.searchByName(text),
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {

          case ConnectionState.none:
            return loadingBar();
          case ConnectionState.waiting:
            return loadingBar();
          case ConnectionState.active:
            return loadingBar();
          case ConnectionState.done:
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                contacts = snapshot.data!;
                return listNewContacts(contacts);
              }
            }
            return loadingBar();
        }
      },
    );
  }

  void updateNewContacts(String text) {
    setState(() {
      this.text = text;
    });
  }
}


Widget listNewContacts(List<Contact> contacts) {

  return ListView.builder(
      padding: EdgeInsets.only(left: 20, right: 20),
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return newContact(context, contacts[index]);
      }
  );
}

Widget newContact(BuildContext context, Contact contact) {
  return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: contact.backgroundColor,
            child: Text(
                style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 24,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w700
                ),
                contact.getInitials()
            ),
          ),

          SizedBox(width: 20),

          Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w900
                      ),
                      "${contact.name} ${contact.surname}"
                  ),

                  Text("В сети")
                ],
              )
          ),
        ],
      )
  );
}

Widget loadingBar() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
