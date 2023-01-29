import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_instagram/src/binding/init_bindings.dart';
import 'package:flutter_instagram/src/model/instagram_user.dart';
import 'package:flutter_instagram/src/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<InstagramUser> user = InstagramUser().obs;

  Future<InstagramUser?> checkLogin(String uid) async {
    var userData = await UserRepository.loginByUd(uid);
    if (userData != null) {
      user(userData);
      InitBinding.additionalBinding();
    }
    return userData;
  }

  void signup(InstagramUser signupUser, XFile? thumbnailXFile) async {
    if (thumbnailXFile == null) {
      _submitSignup(signupUser);
      return;
    }

    var ext = thumbnailXFile.path.split('.').last;
    var task = uploadXFile(thumbnailXFile, '${signupUser.uid}/profile.$ext');
    task.snapshotEvents.listen((event) async {
      if (event.bytesTransferred == event.totalBytes && event.state == TaskState.success) {
        var downloadUrl = await event.ref.getDownloadURL();
        var updatedUser = signupUser.copyWith(thumbnail: downloadUrl);
        _submitSignup(updatedUser);
      }
    });
  }

  void _submitSignup(InstagramUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) {
      checkLogin(signupUser.uid!);
    }
  }

  UploadTask uploadXFile(XFile file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    return ref.putFile(f, metadata); // users/{uid}/profile.jpg
  }
}
