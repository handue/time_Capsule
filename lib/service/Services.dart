import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:time_capsule/Model/PostModel.dart';

class Services {
  static Future<List<PostModel>?> fetchPosts(String address) async {
    await Future.delayed(const Duration(seconds: 2));
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      List<PostModel> postList =
          parsed.map<PostModel>((json) => PostModel.fromJson(json)).toList();
      // posts.assignAll(postList);
      return postList;
    } else {
      print("데이터 제대로 안 넘어옴");
      return null;
    }
  }
}
