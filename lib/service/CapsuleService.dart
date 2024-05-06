import 'dart:convert';
import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:http/http.dart' as http;

class CapsuleService {
  static CapsuleModel capsuleCreate() {
    return CapsuleModel(
      cid: null,
      partyName: "파티 이름",
      title: "타이틀",
      contents: "내용",
      latitude: 37.272206,
      longitude: 127.056204,
      locationName: "서울",
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: '',
      image: "이미지_경로",
      like: 100,
      nickname: "닉네임",
      capsuleLike: false,
      capsuleComment: ['홍준택 폼 미쳤다', '홍준택 그냥 미쳤다'],
    );
  }

  static Future<CapsuleModel?> capsuleSend(String address, capsule) async {
    // todo: capsule 이것도 capsuleCreate 통해서 만들어진 capsuleModel을 토대로 해야함.

    var response = await http.post(Uri.parse(address),
        headers: <String, String>{
          'Content-Type': 'application/json; charset = UTF-8',
        },
        body: jsonDecode(capsule));
    if (response == 200) {
      // Todo: 성공했을 때
      Cap
    } else {
      // Todo: 실패했을 때
    }
    return null;
  }

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
