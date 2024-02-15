import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_project/classes/Contact.dart';
import 'package:new_project/screens/fragments/Contacts.dart';
import 'package:new_project/screens/fragments/NewContacts.dart';

import 'Chat.dart';

class Chats extends StatefulWidget {

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  Widget mainContent = Contacts("");
  List<Widget> backButton = [];
  var _controller = TextEditingController();
  String id = "";


  @override
  Widget build(BuildContext context) {
    if (id.isEmpty){
      id = ModalRoute.of(context)?.settings.arguments as String;
    }
    if (mainContent is Contacts) {
      (mainContent as Contacts).id = id;
    }
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                header(changeToNewContacts, changeToContacts, backButton, _controller),
                Divider(thickness: 1, color: Color(0xFFEDF2F6),),
                Expanded(
                    flex: 1,
                    child: mainContent
                )
              ],
            )
        )
    );
  }

  void changeToNewContacts(String? text) {
    setState(() {
      if (text != null) {
        (mainContent as NewContacts).state.updateNewContacts(text);
      } else {
        mainContent = NewContacts(id);
      }
      backButton = <Widget>[
        GestureDetector(
          onTap: () {
            _controller.clear();
            changeToContacts();
          },
          child: SvgPicture.asset("assets/icons/back.svg")
        ),

        SizedBox(width: 10)
      ];
    });
  }


  void changeToContacts() {
    setState(() {
      mainContent = Contacts("");
      backButton = [];
    });
  }

}


Widget header(Function changeToNewContacts, Function changeToContacts, List<Widget> backButton, TextEditingController controller) {

  return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: backButton + [
                Text(
                  style: TextStyle(fontSize: 32, fontFamily: "Gilroy", fontWeight: FontWeight.w900, height: 2),
                  "Чаты",
                )
              ],
            )
            ,

            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFEDF2F6)
              ),
              child: TextField(
                controller: controller,
                onTap: () {
                  changeToNewContacts(null);
                },

                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },

                onChanged: (text) {
                  changeToNewContacts(text);
                },

                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(5),
                    child: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  hintText: "Поиск",
                  hintStyle: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF9DB7CB),
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xFFEDF2F6),
                ),

                style: TextStyle(
                  fontFamily: "Gilroy",
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),

              ),
            )
          ],
        ),
      ),
    );
}