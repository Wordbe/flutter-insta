import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/src/model/instagram_user.dart';

class UserRepository {
  static Future<InstagramUser?> loginByUd(String uid) async {
    var data = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: uid).get();

    if (data.size == 0) {
      return null;
    }

    return InstagramUser.fromJson(data.docs.first.data());
  }
}
