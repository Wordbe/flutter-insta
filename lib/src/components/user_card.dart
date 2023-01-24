import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String username;
  final String description;

  const UserCard({
    Key? key,
    required this.username,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 150,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: Colors.black12,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                const SizedBox(height: 10),
                AvatarWidget(
                  thumbnailPath:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEpOB50Gf-839DMNoHRlYYBAWP0TN73RHsGg&usqp=CAU',
                  type: AvatarType.TYPE2,
                  size: 80,
                ),
                const SizedBox(height: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('팔로우'),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
