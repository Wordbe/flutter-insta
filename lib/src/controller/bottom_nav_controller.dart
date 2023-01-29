import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/message_popup.dart';
import 'package:flutter_instagram/src/controller/upload_controller.dart';
import 'package:flutter_instagram/src/pages/upload.dart';
import 'package:get/get.dart';

enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();
  GlobalKey<NavigatorState> searchPageNavKey = GlobalKey<NavigatorState>();
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.UPLOAD:
        Get.to(() => Upload(), binding: BindingsBuilder(() {
          Get.put(UploadController());
        }));
        break;
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                title: '시스템',
                message: '종료하시겠습니까?',
                okCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back,
              ));
      return true;
    } else {
      var currPage = PageName.values[bottomHistory.last];
      if (currPage == PageName.SEARCH) {
        var popped = await searchPageNavKey.currentState!.maybePop();
        if (popped) return false;
      }

      bottomHistory.removeLast();
      changeBottomNav(bottomHistory.last, hasGesture: false);
      return false;
    }
  }
}
