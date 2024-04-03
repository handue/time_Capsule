import 'dart:convert';

import 'package:get/get.dart';

import 'package:time_capsule/Model/PostModel.dart';
import 'package:http/http.dart' as http;
import 'package:time_capsule/service/Services.dart';

class PostController extends GetxController {
  RxList<PostModel> postList = RxList<PostModel>().obs();
  RxString postText = ''.obs;

  void sendData() async {}

  void fetchData() async {
    var posts = await Services.fetchPosts(
        'https://codingapple1.github.io/app/data.json');
    if (posts != null) {
      postList.value = posts;
      print(posts);
    } else {
      print("fetchData할 때 포스트 값들이 null임");
    }
  }

  Future<void> createPost(String address, Map<String, dynamic> data) async {
    var response = await http.post(Uri.parse(address), body: data);
    if (response.statusCode == 200) {
      print('게시글 등록 성공');
    } else {
      print('게시글 등록 실패: ${response.body}');
    }
  }

  Future<void> updatePost(String address, Map<String, dynamic> data) async {
    var response = await http.put(Uri.parse(address), body: data);
    if (response.statusCode == 200) {
      print('게시글 수정 성공');
    } else {
      print('게시글 수정 실패: ${response.body}');
    }
  }

  //'api/posts/${posts[index].id}' 약간 이런식으로 보내면 될듯?

  Future<void> deletePost(String address) async {
    var response = await http.delete(Uri.parse(address));
    if (response.statusCode == 200) {
      print('게시글 삭제 성공');
    } else {
      print('게시글 삭제 실패: ${response.body}');
    }
  }

  // void deletePost(PostModel post) {}

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
  }
}
