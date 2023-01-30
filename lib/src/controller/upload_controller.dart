import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/message_popup.dart';
import 'package:flutter_instagram/src/controller/auth_controller.dart';
import 'package:flutter_instagram/src/model/post.dart';
import 'package:flutter_instagram/src/repository/post_repository.dart';
import 'package:flutter_instagram/src/utils/data_util.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/photofilters.dart';

import '../pages/upload/upload_description.dart';

class UploadController extends GetxController {
  List<AssetPathEntity> albums = <AssetPathEntity>[];
  RxList<AssetEntity> images = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedImage = const AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  RxString headerTitle = ''.obs;
  File? filteredImage;
  TextEditingController textEditingController = TextEditingController();
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.user.value);
    _loadPhotos();
  }

  void _loadPhotos() async {
    var permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minWidth: 100, minHeight: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {
      // message 권한 요청
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);
    // update();
  }

  Future<void> _pagePhotos(AssetPathEntity album) async {
    images.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 28);
    images.addAll(photos);
    changeSelectedImage(images.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagePhotos(album);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    Map imageFile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );

    if (imageFile.containsKey('image_filtered')) {
      filteredImage = imageFile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unFocusKeyboard();
    String filename = '${AuthController.to.user.value.uid}/${DataUtil.makeFilePath('jpg')}';
    var task = uploadFile(filteredImage!, filename);
    task.snapshotEvents.listen(
      (event) async {
        if (event.bytesTransferred == event.totalBytes && event.state == TaskState.success) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );
          _submitPost(updatedPost);
        }
      },
    );
  }

  UploadTask uploadFile(File file, String filename) {
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    return ref.putFile(file, metadata); // users/{uid}/profile.jpg
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료 되었습니다.',
        okCallback: () {
          Get.until((route) => Get.currentRoute == '/');
        },
      ),
    );
  }
}
