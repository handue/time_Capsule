import 'dart:convert';
import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:http/http.dart' as http;

class CapsuleService {
  //아래거가 캡슐 List 가져오는거
  static Future<List<CapsuleModel>?> fetchCapsuleList(String address) async {
    // await Future.delayed(const Duration(seconds: 2));
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      List<CapsuleModel> capsuleList = parsed
          .map<CapsuleModel>((json) => CapsuleModel.fromJson(json))
          .toList();
      // posts.assignAll(postList);
      return capsuleList;
    } else {
      print("데이터 제대로 안 넘어옴");
      return null;
    }
  }

  // 이게 캡슐 단 하나의 정보만 가져오는거
  static Future<CapsuleModel?> fetchCapsule(String address) async {
    // await Future.delayed(const Duration(seconds: 2));
    var response = await http.get(Uri.parse(address));
    if (response.statusCode == 200) {
      var responseBody = response.body;
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      CapsuleModel capsule = CapsuleModel.fromJson(parsed);
      // posts.assignAll(postList);
      return capsule;
    } else {
      print("데이터 제대로 안 넘어옴");
      return null;
    }
  }
}
