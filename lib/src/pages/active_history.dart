import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '활동',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _recentlyActiveView('오늘'),
            _recentlyActiveView('이번주'),
            _recentlyActiveView('이번달'),
          ],
        ),
      ),
    );
  }

  Widget _recentlyActiveView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 15),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
          _activeItem(),
        ],
      ),
    );
  }

  Widget _activeItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          AvatarWidget(
            thumbnailPath:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEpOB50Gf-839DMNoHRlYYBAWP0TN73RHsGg&usqp=CAU',
            type: AvatarType.TYPE2,
            size: 40,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text.rich(
              TextSpan(
                text: 'dev_man',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '님이 회원님의 게시물을 좋아합니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' 5일 전',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
