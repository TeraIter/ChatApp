import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_project/classes/contact.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFEDF2F6),
          onPressed: () {},
          child: SvgPicture.asset("assets/icons/pen.svg"),
        ),
        body: Column(
          children: [
            header(),
            Divider(thickness: 1, color: Color(0xFFEDF2F6),),
            Expanded(
              flex: 1,
                child: listContacts(context)
            )
          ],
        )
      );
  }
}

Widget header() {
  return
    Padding(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Container(
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              style: TextStyle(fontSize: 32, fontFamily: "Gilroy", fontWeight: FontWeight.w900, height: 2),
              "Чаты",
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: const Color(0xFFEDF2F6),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                      child: SvgPicture.asset("assets/icons/search.svg"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        style: TextStyle(
                            color: Color(0xFF9DB7CB),
                            fontSize: 16,
                            fontFamily: "Gilroy"
                        ),
                        "Поиск",
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
}

Widget listContacts(BuildContext context) {
  List<Contact> contacts = <Contact>[Contact("Виктор", "Власов"), Contact("Саша", "Алексеев"), Contact("Пётр", "Жаринов")];

  return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return contact(context, contacts[index]);
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
            Expanded(
                flex: 0,
                child: CircleAvatar(
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
                )
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
