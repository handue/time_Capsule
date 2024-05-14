import 'dart:convert';
import 'package:get/get.dart';
import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:http/http.dart' as http;

class CapsuleController extends GetxController {
  RxList<CapsuleModel?> capsuleList = RxList<CapsuleModel?>([]);
  //! 위에 capsuleList 왜 만들어놨더라. 아래는 근처 500m내에 있는 캡슐들 가져오려고 한거. 위에는 뭐징.. 일단 냅두자 아 그 파티 캡슐들 모아두려고 하는건가 그거 아니고 마커들 생성할때 쓰려고 냅둔거네
  RxList<CapsuleModel?> nearCapsuleList = RxList<CapsuleModel?>([]);
  Rx<CapsuleModel?> newCapsule = Rx<CapsuleModel?>(null);

  RxString capsuleTitle = ''.obs;
  RxString capsuleCreatedTime = ''.obs;
  RxString capsuleParty = ''.obs;
  RxString capsuleContents = ''.obs;
  RxString capsuleLocationName = ''.obs;
  RxString capsuleNickname = ''.obs;
  RxInt capsuleLike = 0.obs;

  static Future<CapsuleModel?> sendCapsule(
      String address, CapsuleModel capsule) async {
    var response = await http.post(Uri.parse(address),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(capsule.toJson()));
    if (response.statusCode == 200) {
      // 성공했을 때 로직
      print("캡슐 전송 성공");
      // return capsule; // 또는 다른 성공 시 반환 객체
      // todo 전송 성공 되면 이 객체 기반으로 구글맵에 뜨게 해줘야함.
    } else {
      // 실패했을 때 로직
      print("캡슐 선공 실패");
      return null;
    }
    return null;
  }
}

// Todo: Test용 capsuleCreate
// * 이거 근데 폼 직접 입력 받은 값으로 생성해야함.
// ! 아무리 생각해도 capsuleCreate 상관 없이 그냥 바로 model 생성하는게 나은듯. 
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

// final capsuleController = CapsuleController();
// CapsuleModel newCapsule = CapsuleModel(
//   partyName: "My Party",
//   title: "My Title",
//   contents: "Some interesting contents",
//   latitude: 37.5665,
//   longitude: 126.9780,
//   locationName: "Seoul",
//   createdAt: DateTime.now().toIso8601String(),
//   image: "path/to/image",
//   like: 0,
//   nickname: "MyNickname",
//   capsuleLike: false,
//   capsuleComment: [],
// );

// capsuleController.sendCapsule("https://yourserver.com/capsules", newCapsule);
