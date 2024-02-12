import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_project/classes/Contact.dart';

class Chat extends StatelessWidget {
  Contact contact = Contact("", "");

  Chat(this.contact);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              header(context, contact),
              Divider(thickness: 1, color: Color(0xFFEDF2F6)),

              Expanded(
                flex: 1,
                  child: content()
              ),

              Divider(thickness: 1, color: Color(0xFFEDF2F6)),
              tabBar()
            ],
          ),
        )
    );
  }
}

Widget header(BuildContext context, Contact contact) {
  return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset("assets/icons/back.svg"),
        ),

        const SizedBox(width: 10),

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

Widget tabBar() {
  double size = 50;
  double iconPadding = 7;

  return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(iconPadding),
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Color(0xFFEDF2F6)
          ),
          child: SvgPicture.asset("assets/icons/attach.svg"),
        ),
        
        SizedBox(width: 5),
        
        Expanded(
          flex: 1,
            child: Container(
              height: size,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xFFEDF2F6)
              ),
              child: TextField(
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Gilroy"
                ),
                decoration: InputDecoration(
                  hintText: "Сообщение",
                  hintStyle: TextStyle(
                      color: Color(0xFF9DB7CB),
                      fontSize: 16,
                      fontFamily: "Gilroy",
                    fontWeight: FontWeight.w900
                  ),
                  border: InputBorder.none,
                ),
              ),
            )
        ),

        SizedBox(width: 5),

        Container(
          padding: EdgeInsets.all(iconPadding),
          height: size,
          width: size,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Color(0xFFEDF2F6)
          ),
          child: SvgPicture.asset("assets/icons/audio.svg"),
        )
      ],
    ),
  );
}

Widget content() {
  return Container();
}