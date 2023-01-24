import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/controller/bottom_nav_controller.dart';
import 'package:flutter_instagram/src/pages/active_history.dart';
import 'package:flutter_instagram/src/pages/home.dart';
import 'package:flutter_instagram/src/pages/mypage.dart';
import 'package:flutter_instagram/src/pages/search.dart';
import 'package:get/get.dart';

import 'components/image_data.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(() => Scaffold(
            appBar: AppBar(),
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                const Home(),
                Navigator(
                  key: controller.searchPageNavKey,
                  onGenerateRoute: (routeSetting) {
                    return MaterialPageRoute(
                      builder: (context) => const Search(),
                    );
                  },
                ),
                Container(),
                const ActiveHistory(),
                const MyPage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              onTap: controller.changeBottomNav,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon),
                  label: 'upload',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'activity',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      )),
                  label: 'mypage',
                ),
              ],
            ),
          )),
    );
  }
}
