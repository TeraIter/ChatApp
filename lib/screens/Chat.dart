import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:new_project/classes/Contact.dart';
import 'package:new_project/classes/MessageType.dart';
import 'package:new_project/firebase/DBFirebaseStorage.dart';
import 'package:new_project/screens/clippers/clipper.dart';

import '../classes/Message.dart';

class Chat extends StatefulWidget {
  Contact contact = Contact("", "", "");
  int chatId = -1;
  String currentMemberId = "";

  Chat(this.contact, this.chatId, this.currentMemberId, {super.key});


  @override
  _ChatState createState() => _ChatState(contact, chatId, currentMemberId);
}

class _ChatState extends State<Chat> {
  Contact contact = Contact("", "", "");
  int chatId = -1;
  String currentMemberId = "";
  late DatabaseReference ref;
  bool fileSelected = false;

  _ChatState(this.contact, this.chatId, this.currentMemberId) {
    ref = FirebaseDatabase.instance.ref("chats/$chatId/messages");

    Query query = ref.orderByKey();


    query.onValue.listen((event) {
      final data = event.snapshot.children;
      updateMessages(data);
    });
  }



  List<Map> messages = [];

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
                  child: content(messages.reversed.toList(), context, currentMemberId)
              ),

              Divider(thickness: 1, color: Color(0xFFEDF2F6)),
              tabBar(ref, currentMemberId, updateMessages)
            ],
          ),
        )
    );
  }

  void updateMessages(Iterable<DataSnapshot> mess) {
      setState(() {
        List<Map> result = [];
        for (var e in mess) {
          if (e.key != "count") {
            result.add(e.value as Map);
          }
        }
        messages = result;
      });
  }

  void updateFileSelected(bool state) {
    setState(() {
      fileSelected = state;
    });
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

Widget tabBar(DatabaseReference ref, String currentMemberId, Function updateFileSelected) {
  double size = 50;
  double iconPadding = 7;
  var _controller = TextEditingController();
  String messageText = "";
  String filePathDB = "";
  String filePathLocal = "";

  return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
    child: Row(
      children: [
        GestureDetector(
          onTap: () async {
            var result = await FilePicker.platform.pickFiles();

            if (result != null) {
              filePathDB = "images/${result.files.single.name}";
              filePathLocal = result.files.single.path!;

            }
          },
          child: Container(
            padding: EdgeInsets.all(iconPadding),
            height: size,
            width: size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xFFEDF2F6)
            ),
            child: SvgPicture.asset("assets/icons/attach.svg"),
          ),
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
                controller: _controller,
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
                onEditingComplete: () async {
                  _controller.clear();


                  try {
                    if (filePathLocal.isNotEmpty) {
                      final storage = FirebaseStorage.instance;
                      File file = File(filePathLocal);
                      storage.ref(filePathDB).putFile(file);
                    }
                  } catch (e) {}


                  final snapshot = await ref.child("count").get();
                  int counter = (snapshot.value as int) + 1;
                  ref.child("$counter").update({
                    "memberId": currentMemberId,
                    "message": messageText,
                    "time": DateTime.now().millisecondsSinceEpoch,
                    "file": filePathDB
                  });
                  ref.update({
                    "count": counter
                  });



                },
                onChanged: (text) {
                  messageText = text;
                },
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

Widget content(List<Map> messages, BuildContext context, String currentMemberId) {
  double messagesSpace = 0;
  MessageType messageType;

  return ListView.builder(
    padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
    reverse: true,

    itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
      String currentMember = messages[index]["memberId"];

      if (index + 1 < messages.length) {
        if (index - 1 > -1) {
          if (currentMember == messages[index - 1]["memberId"] && currentMember == messages[index + 1]["memberId"]) {
            messageType = MessageType.middle;
            messagesSpace = 6;
          } else if (currentMember != messages[index - 1]["memberId"] && currentMember != messages[index + 1]["memberId"]){
            messageType = MessageType.single;
            messagesSpace = 16;
          } else if (currentMemberId != messages[index - 1]["memberId"]) {
            messageType = MessageType.bottom;
            messagesSpace = 16;
          } else {
            messageType = MessageType.upper;
            messagesSpace = 6;
          }
        } else {
          if (currentMemberId == messages[index + 1]["memberId"]) {
            messageType = MessageType.bottom;
          } else {
            messageType = MessageType.single;
          }
          messagesSpace = 0;
        }
      } else {
        if (index - 1 > -1) {
          if (messages[index - 1]["memberId"] == currentMember) {
            messageType = MessageType.upper;
            messagesSpace = 6;
          } else {
            messageType = MessageType.single;
            messagesSpace = 16;
          }
        } else {
          messageType = MessageType.single;
        }
      }


        Message message = Message(messages[index]["message"], currentMember, messages[index]["time"], messages[index]["file"]);
        return messageBox(message, context, currentMember == currentMemberId ? true : false, messagesSpace, messageType);
      }
  );
}

Widget messageBox(Message message, BuildContext context, bool fromCurrentMember, double messageSpace, MessageType messageType) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(message.time);
  DateFormat formatter = DateFormat("Hm");


  return Column(
    children: [

      Row(
          children: [
            fromCurrentMember ?
            Spacer(
              flex: 1,
            )
            :
            Container()
            ,

            ClipPath(
              clipper: Clipper(fromCurrentMember, messageType),
              child: Container(
                  padding: EdgeInsets.only(left: fromCurrentMember ? 12:22, top: 10, bottom: 10, right: fromCurrentMember?22:12),
                  decoration: BoxDecoration(
                    color: fromCurrentMember ? Color(0xFF3CED78) : Color(0xFFEDF2F6),
                  ),
                  child: Column(
                    children: [
                      //Image.network(url),

                    Row(
                      children: [
                        Text(
                            style: TextStyle(
                                fontFamily: "Gilroy",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: fromCurrentMember ? Color(0xFF00521C) : Color(0xFF2B333E)
                            ),
                            message.text
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Text(
                            style: TextStyle(
                                fontFamily: "Gilroy",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: fromCurrentMember ? Color(0xFF00521C) : Color(0xFF2B333E)
                            ),
                            formatter.format(time)
                        ),

                        fromCurrentMember ?
                        Row(
                          children: [
                            SizedBox(width: 4,),

                            SvgPicture.asset("assets/icons/read.svg"),
                          ],
                        )
                            :
                        Container()
                      ],
                    ),
                  ],
                  )
              ),
            ),

            fromCurrentMember ?
            Container()
                :
            Spacer(
              flex: 1,
            )

          ]
      ),

      SizedBox(height: messageSpace,)
    ],
  );
}