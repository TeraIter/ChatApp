import 'package:flutter/cupertino.dart';

import '../../classes/MessageType.dart';

class Clipper extends CustomClipper<Path> {
  bool fromCurrentMember;
  MessageType messageType;

  Clipper(this.fromCurrentMember, this.messageType);

  @override
  Path getClip(Size size) {
    double radius = 20;
    double smallRadius = 6;
    Path path;

    switch (messageType) {
      case MessageType.single:
        if (fromCurrentMember) {
          path = Path()
            ..moveTo(radius, 0)
            ..lineTo(size.width - (radius + 10), 0)
            ..arcToPoint(Offset(size.width - 10, radius), radius: Radius.circular(radius))
            ..lineTo(size.width - 10, size.height - radius)
            ..arcToPoint(Offset(size.width, size.height), radius: Radius.elliptical(10, radius), clockwise: false)
            ..lineTo(radius, size.height)
            ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
            ..lineTo(0, radius)
            ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
            ..close();
        } else {
          path = Path()
            ..moveTo(size.width - radius, 0)
            ..lineTo(radius + 10, 0)
            ..arcToPoint(Offset(10, radius), radius: Radius.circular(radius), clockwise: false)
            ..lineTo(10, size.height - radius)
            ..arcToPoint(Offset(0, size.height), radius: Radius.elliptical(10, radius))
            ..lineTo(size.width - radius, size.height)
            ..arcToPoint(Offset(size.width, size.height - radius), radius: Radius.circular(radius), clockwise: false)
            ..lineTo(size.width, radius)
            ..arcToPoint(Offset(size.width - radius, 0), radius: Radius.circular(radius), clockwise: false);
        }
      case MessageType.bottom:
        if (fromCurrentMember) {
          path = Path()
            ..moveTo(radius, 0)
            ..lineTo(size.width - (smallRadius + 10), 0)
            ..arcToPoint(Offset(size.width - 10, smallRadius), radius: Radius.circular(smallRadius))
            ..lineTo(size.width - 10, size.height - radius)
            ..arcToPoint(Offset(size.width, size.height), radius: Radius.elliptical(10, radius), clockwise: false)
            ..lineTo(radius, size.height)
            ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
            ..lineTo(0, radius)
            ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
            ..close();
        } else {
          path = Path()
            ..moveTo(size.width - radius, 0)
            ..lineTo(smallRadius + 10, 0)
            ..arcToPoint(Offset(10, smallRadius), radius: Radius.circular(smallRadius), clockwise: false)
            ..lineTo(10, size.height - radius)
            ..arcToPoint(Offset(0, size.height), radius: Radius.elliptical(10, radius))
            ..lineTo(size.width - radius, size.height)
            ..arcToPoint(Offset(size.width, size.height - radius), radius: Radius.circular(radius), clockwise: false)
            ..lineTo(size.width, radius)
            ..arcToPoint(Offset(size.width - radius, 0), radius: Radius.circular(radius), clockwise: false);
        }
      case MessageType.middle:
        if (fromCurrentMember) {
          path = Path()
            ..moveTo(radius, 0)
            ..lineTo(size.width - (smallRadius + 10), 0)
            ..arcToPoint(Offset(size.width - 10, smallRadius), radius: Radius.circular(smallRadius))
            ..lineTo(size.width - 10, size.height - smallRadius)
            ..arcToPoint(Offset(size.width - (10 + smallRadius), size.height), radius: Radius.circular(smallRadius))
            ..lineTo(radius, size.height)
            ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
            ..lineTo(0, radius)
            ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
            ..close();
        } else {
          path = Path()
            ..moveTo(size.width - radius, 0)
            ..lineTo(smallRadius + 10, 0)
            ..arcToPoint(Offset(10, smallRadius), radius: Radius.circular(smallRadius), clockwise: false)
            ..lineTo(10, size.height - smallRadius)
            ..arcToPoint(Offset(smallRadius, size.height), radius: Radius.circular(smallRadius), clockwise: false)
            ..lineTo(size.width - radius, size.height)
            ..arcToPoint(Offset(size.width, size.height - radius), radius: Radius.circular(radius), clockwise: false)
            ..lineTo(size.width, radius)
            ..arcToPoint(Offset(size.width - radius, 0), radius: Radius.circular(radius), clockwise: false);
        }
      case MessageType.upper:
        if (fromCurrentMember) {
          path = Path()
            ..moveTo(radius, 0)
            ..lineTo(size.width - (radius + 10), 0)
            ..arcToPoint(Offset(size.width - 10, radius), radius: Radius.circular(radius))
            ..lineTo(size.width - 10, size.height - smallRadius)
            ..arcToPoint(Offset(size.width - (10 + smallRadius), size.height), radius: Radius.circular(smallRadius))
            ..lineTo(radius, size.height)
            ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius))
            ..lineTo(0, radius)
            ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
            ..close();
        } else {
          path = Path()
            ..moveTo(size.width - radius, 0)
            ..lineTo(radius + 10, 0)
            ..arcToPoint(Offset(10, radius), radius: Radius.circular(radius), clockwise: false)
            ..lineTo(10, size.height - smallRadius)
            ..arcToPoint(Offset(10 + smallRadius, size.height), radius: Radius.circular(smallRadius), clockwise: false)
            ..lineTo(size.width - radius, size.height)
            ..arcToPoint(Offset(size.width, size.height - radius), radius: Radius.circular(radius), clockwise: false)
            ..lineTo(size.width, radius)
            ..arcToPoint(Offset(size.width - radius, 0), radius: Radius.circular(radius), clockwise: false);
        }
    }


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}