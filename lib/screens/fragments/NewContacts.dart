import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/contact.dart';

class NewContacts extends StatefulWidget {

  @override
  _NewContactsState createState() => _NewContactsState();
}

class _NewContactsState extends State<NewContacts> {
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return listNewContacts(contacts);
  }

  void updateNewContacts() {
    setState(() {

    });
  }
}

void updateNewContacts() {

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
