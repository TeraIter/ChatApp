import 'package:firebase_storage/firebase_storage.dart';

class DBFirebaseStorage {
  static final ref = FirebaseStorage.instance.ref();

  static Future<String> getPicture(String path) async {
    return await ref.child(path).getDownloadURL();
  }
}