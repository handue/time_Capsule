import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/model/CapsuleModel.dart';

class UnityService {
  LocationController locationController = Get.find<LocationController>();

  bool isCapsuleExist = false;

  //현재 위치 계속 동기화 하면서 백엔드에서 주위에 있는 캡슐 있으면 가져오도록 해야함. 이때 false를 true 로 바꿔서 진행.

  static Future<String> prepareImage(String path) async {
    // ByteData imageData = await rootBundle.load('../images/testpic.png');
    ByteData imageData = await rootBundle.load(path);
    List<int> bytes = imageData.buffer.asUint8List();

    String base64Image = base64Encode(bytes);

    return base64Image;
  }

  Future<List<CapsuleModel>?> searchCapsule() async {
    var currentLocation = locationController.currentPosition.value;
    var response = await http.post(
      Uri.parse('백엔드캡슐찾는uri'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'latitude': currentLocation!.latitude,
        'longitude': currentLocation.longitude,
        'radius': 100,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data != null) {
        //여기서 iscapsuleexsit 하는거보다 그냥 바로 함수 짜서 유니티에 명령 보내는게 나은거 같은데
      }
    } else {
      throw Exception('서버 에러');
    }
    return null;
  }
}
