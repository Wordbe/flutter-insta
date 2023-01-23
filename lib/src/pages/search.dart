import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<List<int>> imageCols = [[], [], []];
  List<int> imageIndex = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      var col = imageIndex.indexOf(min<int>(imageIndex)!);
      var size = 1;
      if (col != 1) {
        size = Random().nextInt(2) % 2 == 0 ? 1 : 2;
      }
      imageCols[col].add(size);
      imageIndex[col] += size;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(), // 상단 고정이 아닌 앱바
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffefefef),
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                Text(
                  '검색',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff838383),
                  ),
                )
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Icon(Icons.location_pin),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          imageCols.length,
          (col) => Expanded(
            child: Column(
              children: List.generate(
                imageCols[col].length,
                (row) => Container(
                  height: Get.width * 0.33 * imageCols[col][row],
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWwfAxrMT8wIJT1tl0aI9pb6MGxFJqlg9u7Q&usqp=CAU',
                    fit: BoxFit.cover,
                  ),
                ),
              ).toList(),
            ),
          ),
        ).toList(),
      ),
    );
  }
}
