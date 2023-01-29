import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

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

  @override
  void onInit() {
    super.onInit();
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
    headerTitle(albums.first.name);
    await _pagePhotos();
    // update();
  }

  Future<void> _pagePhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 28);
    images.addAll(photos);
    changeSelectedImage(images.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }
}
