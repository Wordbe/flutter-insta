import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/controller/auth_controller.dart';
import 'package:flutter_instagram/src/model/instagram_user.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  final String uid;

  const Signup({Key? key, required this.uid}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _avatar(),
            const SizedBox(height: 30),
            _nickname(),
            const SizedBox(height: 30),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: ElevatedButton(
          onPressed: () {
            var signupUser = InstagramUser(
              uid: widget.uid,
              nickname: nicknameController.text,
              description: descriptionController.text,
            );
            AuthController.to.signup(signupUser, thumbnailXFile);
          },
          child: const Text('회원가입'),
        ),
      ),
    );
  }

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: thumbnailXFile == null
                ? Image.asset(
                    'assets/images/default_image.png',
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(thumbnailXFile!.path),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () async {
            thumbnailXFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
            update();
          },
          child: const Text('이미지 변경'),
        ),
      ],
    );
  }

  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '닉네임',
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: '설명',
        ),
      ),
    );
  }

  void update() => setState(() {});
}
