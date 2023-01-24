import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/src/components/image_data.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<AssetPathEntity> albums = <AssetPathEntity>[];
  List<AssetEntity> images = <AssetEntity>[];
  AssetEntity? selectedImage;
  String headerTitle = '';

  @override
  void initState() {
    super.initState();
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
    headerTitle = albums.first.name;
    await _pagePhotos();
    update();
  }

  Future<void> _pagePhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 28);
    images.addAll(photos);
    selectedImage = images.first;
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width,
      color: Colors.grey,
      child: _photoWidget(
        selectedImage!,
        width.toInt(),
        builder: (data) => Image.memory(
          data,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                isScrollControlled: albums.length > 10 ? true : false,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                ),
                builder: (_) => SizedBox(
                  height: albums.length > 10 ? Size.infinite.height : albums.length * 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          width: 40,
                          height: 4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              10,
                              // albums.length,
                              (index) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                child: Text('albums[index].name'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xff808080),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    ImageData(IconsPath.imageSelectIcon),
                    const SizedBox(width: 7),
                    const Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1,
      ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) => _photoWidget(
        images[index],
        200,
        builder: (data) => GestureDetector(
          onTap: () {
            selectedImage = images[index];
            update(); // stateful > builder 가 다시 실행되면서 화면에 깜빡이는 현상 발생 -> 추후 Getx 로 변경
          },
          child: Opacity(
            opacity: images[index] == selectedImage ? 0.3 : 1,
            child: Image.memory(
              data,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _photoWidget(AssetEntity asset, int size, {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }
}
