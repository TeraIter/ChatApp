import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/contact.dart';
import '../Chat.dart';

class Contacts extends StatefulWidget {

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  @override
  Widget build(BuildContext context) {
    return listContacts();
  }
}

Widget listContacts() {
  List<Contact> contacts = <Contact>[Contact("Виктор", "Власов"), Contact("Саша", "Алексеев"), Contact("Пётр", "Жаринов")];

  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    itemCount: contacts.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(contacts[index])));
        },
        child: contact(context, contacts[index]),
      );
    },
  );
}

Widget contact(BuildContext context, Contact contact) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child:
        Row(
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
                flex: 3,
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
                    Text("Сообщение")
                  ],)
            ),

            SizedBox(width: 20),

            Expanded(
              flex: 2,
              child: Align(
                heightFactor: 3,
                alignment: Alignment.topRight,
                child: Text(
                    style: TextStyle(
                        color: Color(0xFF5E7A90),
                        fontFamily: "Gilroy",
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    ),
                    "Вчера"
                ),
              ),
            ),

          ],
        ),
      ),

      Divider(
        thickness: 1,
        color: Color(0xFFEDF2F6),
      )
    ],
  );
}