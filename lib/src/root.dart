import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/app.dart';
import 'package:flutter_instagram/src/controller/auth_controller.dart';
import 'package:flutter_instagram/src/model/instagram_user.dart';
import 'package:flutter_instagram/src/pages/login.dart';
import 'package:flutter_instagram/src/pages/signup.dart';
import 'package:get/get.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return FutureBuilder<InstagramUser?>(
            future: controller.checkLogin(user.data!.uid),
            builder: (BuildContext context, AsyncSnapshot<InstagramUser?> snapshot) {
              if (snapshot.hasData) {
                return const App();
              }
              return Obx(
                () => controller.user.value.uid == null ? Signup(uid: user.data!.uid) : const App(),
              );
            },
          );
        }
        return const Login();
      },
    );
  }
}
