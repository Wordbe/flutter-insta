import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/avatar_widget.dart';
import 'package:flutter_instagram/src/components/image_data.dart';
import 'package:flutter_instagram/src/controller/home_controller.dart';
import 'package:get/get.dart';

import '../components/post_widget.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          thumbnailPath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK5HErGV-n_nrGoUmc4gubEbikn3YkhhKQZT-xcB5g23Aw7taTb1tttwh4kLGNULX5bUg&usqp=CAU',
          type: AvatarType.TYPE2,
          size: 70,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 20),
          _myStory(),
          const SizedBox(width: 5),
          ...List.generate(
            100,
            (index) => AvatarWidget(
              thumbnailPath:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDvYYiAt_WjzQ5lueNSWMwHNjp7UV5mjBXOg&usqp=CAU',
              type: AvatarType.TYPE1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _postList() {
    return Obx(
      () => Column(
        children: List.generate(
          controller.postList.length,
          (index) => PostWidget(post: controller.postList[index]),
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // ????????? 0: ?????????, 1: ?????????
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList(),
        ],
      ),
    );
  }
}
