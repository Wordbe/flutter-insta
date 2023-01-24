import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/image_data.dart';
import 'package:flutter_instagram/src/controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
          ),
        ),
        bottom: _tapMenu(),
      ),
      body: _body(),
    );
  }

  PreferredSizeWidget _tapMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        width: Size.infinite.width,
        height: AppBar().preferredSize.height,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffe4e4e4))),
        ),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          tabs: [
            _tabMenuElem('인기'),
            _tabMenuElem('계정'),
            _tabMenuElem('오디오'),
            _tabMenuElem('태그'),
            _tabMenuElem('장소'),
          ],
        ),
      ),
    );
  }

  Widget _tabMenuElem(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        menu,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text('인기페이지')),
        Center(child: Text('계정페이지')),
        Center(child: Text('오디오페이지')),
        Center(child: Text('태그페이지')),
        Center(child: Text('장소페이지')),
      ],
    );
  }
}
