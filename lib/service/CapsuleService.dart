import 'dart:convert';
import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:http/http.dart' as http;

class CapsuleService {

  //! 서버로 내 캡슐 만든거 보내는 함수

//    Future<CapsuleModel?> sendCapsule(
//       String address, CapsuleModel capsule) async {
//     var response = await http.post(Uri.parse(address),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(capsule.toJson()));
//     if (response.statusCode == 200) {
//       // 성공했을 때 로직
//       print("캡슐 전송 성공");
//       // return capsule; // 또는 다른 성공 시 반환 객체
//       // todo 전송 성공 되면 이 객체 기반으로 구글맵에 뜨게 해줘야함.
//     } else {
//       // 실패했을 때 로직
//       print("캡슐 선공 실패");
//       return null;
//     }
//     return null;
//   }

// // Todo: Test용 capsuleCreate
// // * 이거 근데 폼 직접 입력 받은 값으로 생성해야함.
  // !테스트시에 사용할게 아니라 실제 캡슐 생성할 떄 써야 할 함수
// CapsuleModel capsuleCreate({
//   int? cid,
//   required String partyName,
//   required String title,
//   required String contents,
//   required double latitude,
//   required double longitude,
//   required String locationName,
//   required String createdAt,
//   String? updatedAt,
//   required String image,
//   required int like,
//   required String nickname,
//   required bool capsuleLike,
//   required List capsuleComment,
// }) {
//   var newCapsule = CapsuleModel(
//       partyName: partyName,
//       title: title,
//       contents: contents,
//       latitude: latitude,
//       longitude: longitude,
//       locationName: locationName,
//       createdAt: createdAt,
//       image: image,
//       like: like,
//       nickname: nickname,
//       capsuleLike: capsuleLike,
//       capsuleComment: capsuleComment);
//   return newCapsule;
// }



  // static CapsuleModel capsuleCreate({
  //   required String partyName,
  //   required String title,
  //   required String contents,
  //   required double latitude,
  //   required double longitude,
  //   required String locationName,
  //   String? createdAt,
  //   String? updatedAt,
  //   required String image,
  //   required int like,
  //   required String nickname,
  //   required bool capsuleLike,
  //   required List capsuleComment,
  // }) {
  //   return CapsuleModel(
  //     partyName: partyName,
  //     title: title,
  //     contents: contents,
  //     latitude: latitude ?? 37.272206,
  //     longitude: longitude ?? 127.056204,
  //     locationName: locationName,
  //     createdAt: createdAt ?? DateTime.now().toIso8601String(),
  //     updatedAt: '',
  //     image: image,
  //     like: like,
  //     nickname: nickname,
  //     capsuleLike: capsuleLike,
  //     capsuleComment: capsuleComment ?? ['홍준택 폼 미쳤다', '홍준택 그냥 미쳤다'],
  //   );
  // }

  // static Future<CapsuleModel?> capsuleSend(String address, capsule) async {
  //   // todo: capsule 이것도 capsuleCreate 통해서 만들어진 capsuleModel을 토대로 해야함.

  //   // var newCapsule = capsuleCreate();

  //   var response = await http.post(Uri.parse(address),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset = UTF-8',
  //       },
  //       body: jsonDecode(capsule));
  //   if (response == 200) {
  //     // Todo: 성공했을 때
  //   } else {
  //     // Todo: 실패했을 때
  //   }
  //   return null;
  // }

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


