import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/controller/auth_controller.dart';
import 'package:flutter_instagram/src/model/instagram_user.dart';
import 'package:get/get.dart';

class MypageController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<InstagramUser> targetUser = InstagramUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void _loadData() {
    setTargetUser();
    // post list load
    // user load
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if (uid == null) {
      targetUser(AuthController.to.user.value);
    } else {
      // targetUser = UserRepository.findByUid(uid);
    }
  }
}
