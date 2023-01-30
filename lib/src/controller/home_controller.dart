import 'package:flutter_instagram/src/model/post.dart';
import 'package:flutter_instagram/src/repository/post_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFeedList();
  }

  void _loadFeedList() async {
    var posts = await PostRepository.getPosts();
    postList.addAll(posts);
  }
}
