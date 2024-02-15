import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/firebase/DBFirestore.dart';

import '../../classes/Contact.dart';
import '../Chat.dart';

class Contacts extends StatefulWidget {
  String id = "";

  Contacts(this.id);

  @override
  _ContactsState createState() => _ContactsState(id);

}

class _ContactsState extends State<Contacts> with WidgetsBindingObserver{
  List<Map> chats = [];
  String id = "";

  _ContactsState(this.id);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      DBFirestore.changeIsOnline(id, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    DBFirestore.changeIsOnline(id, true);
    DBFirestore.getChats(id)
    .then((value) {
      return listContacts(value, id);
    });
    /*return FutureBuilder(
      future: DBFirestore.getChats(id),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null) {
            chats = snapshot.data!;
          }
        } else {
          return loadingBar();
        }
        return listContacts(chats, id);

      },
    );*/
    return loadingBar();
  }
}

Widget listContacts(List<Map> contacts, String currentMemberId) {

  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    itemCount: contacts.length,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(contacts[index]["contact"], contacts[index]["chatId"], currentMemberId)));
        },
        child: contact(context, contacts[index]["contact"]),
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

Widget loadingBar() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
