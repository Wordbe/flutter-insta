import 'package:flutter_instagram/src/model/instagram_user.dart';
import 'package:flutter_instagram/src/repository/user_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<InstagramUser?> checkLogin(String uid) async {
    var user = await UserRepository.loginByUd(uid);
    return user;
  }
}
