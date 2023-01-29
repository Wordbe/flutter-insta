import 'package:flutter_instagram/src/model/instagram_user.dart';
import 'package:flutter_instagram/src/repository/user_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<InstagramUser> user = InstagramUser().obs;

  Future<InstagramUser?> checkLogin(String uid) async {
    var user = await UserRepository.loginByUd(uid);
    return user;
  }

  void signup(InstagramUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      user(signupUser);
    }
  }
}
