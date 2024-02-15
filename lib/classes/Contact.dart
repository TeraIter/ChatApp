import 'dart:math';
import 'dart:ui';


final List<Color> _colors = [
  const Color(0xFF1FDB5F),
  const Color(0xFFF66700),
  const Color(0xFF00ACF6)];
final _random = Random();

class Contact {
  String id = "";
  String name = "";
  String surname = "";
  Color backgroundColor = _colors[_random.nextInt(_colors.length)];

  Contact(this.id, this.name, this.surname);

  String getInitials() {
    if (name.isNotEmpty && surname.isNotEmpty) {
      return "${name[0]}${surname[0]}".toUpperCase();
    } else {
      return "Null";
    }
  }
}