import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:time_capsule/controller/CapsuleController.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/screen/AddPostPage.dart';
import 'package:time_capsule/screen/CapsuleDetail.dart';
import 'package:time_capsule/service/UnityService.dart';

class UnityAr extends StatefulWidget {
  const UnityAr({super.key});

  @override
  State<UnityAr> createState() => _UnityArState();
}

class _UnityArState extends State<UnityAr> {
  LocationController locationController = Get.find<LocationController>();
  CapsuleController capsuleController = Get.find<CapsuleController>();
  late List<int> cidsJson = [];
  late UnityWidgetController _unityWidgetController;

  void onUnityCreated(UnityWidgetController controller) {
    _unityWidgetController = controller;
    sendUnityMessage();
  }

  // 카메라 눌렀을 때 캡슐 업데이트 되도록 했는데, 나중에 수정하긴 해야함
  void searchCapsule() {
    //위도 경도 DB로 보내기만 하면 알아서 주변 컨텐츠들은 가져올 수 있음.
    // 그러니까 그냥 db로 현재 내 위치 보내는것만 하면 될듯.
    locationController.currentPosition.value?.longitude;
    locationController.currentPosition.value?.latitude;
  }

  void onUnityMessage(message) {
    List<String> parts = message.split(',');
    if (message == "addPost") {
      Get.to(() => AddPostPage());
    }
    if (parts[0] == "touchCapsule") {
      int cid = int.parse(parts[1]);
      String title = parts[2];
      //todo: 이 cid랑 title 토대로 capsuleDetail 창 열어야되고, 데이터베이스에는 이 cid 동일한거 가져오라고 나중에 명령어 기록하면 될듯. 현재 이 상황은 unity 상황에서 캡슐이 터치된 상황.

      for (int i = 0; i < capsuleController.capsuleList.length; i++) {
        if (capsuleController.capsuleList[i]!.cid == cid) {
          capsuleController.capsuleContents.value =
              capsuleController.capsuleList[i]?.contents ?? 'no contents';
          capsuleController.capsuleLike.value =
              capsuleController.capsuleList[i]!.like;
          capsuleController.capsuleLocationName.value =
              capsuleController.capsuleList[i]?.locationName ??
                  'no location name';
          capsuleController.capsuleTitle.value =
              capsuleController.capsuleList[i]?.title ?? 'no title';
          capsuleController.capsuleParty.value =
              capsuleController.capsuleList[i]?.partyName ?? 'no party Name';
          capsuleController.capsuleNickname.value =
              capsuleController.capsuleList[i]?.nickname ?? 'no nickname';
          capsuleController.capsuleCreatedTime.value =
              DateFormat('yyyy-MM-dd HH:mm')
                  .format(capsuleController.capsuleList[i]!.createdAt);
          Get.to(() => CapsuleDetail());
        }
      }
    }
  }
  // ! 5월14일 유니티 수신 오류 - 오후 10시 37분 해결완료
  // FIXME: 유니티로 메시지 전송은 되는데, 유니티에서 수신이 안됨.

  void sendUnityMessage() async {
    for (int i = 0; i < capsuleController.nearCapsuleList.value.length; i++) {
      String sendMessage =
          "${capsuleController.nearCapsuleList.value[i]?.cid},${capsuleController.nearCapsuleList.value[i]?.title}";

      // _unityWidgetController.postMessage('CapsuleSpawner', "receiveCidMessage",
      //     "${capsuleController.nearCapsuleList.value[i]?.cid}");

      _unityWidgetController.postMessage(
          'CapsuleSpawner', "receiveMessage", sendMessage);
      // _unityWidgetController.postMessage(

      // )

      print('유니티 메시지 전송 완료: $sendMessage');
    }
    // todo: 임의로 캡슐 눌렀을 때 사진 밖으로 나오나 테스트 해보려고 이렇게 했음.
    try {
      Future<String> sendImage =
          UnityService.prepareImage('../images/testpic.png');
      _unityWidgetController.postMessage('Canvas', 'receiveImage', sendImage);
      print('유니티 이미지 전송 완료: $sendImage');
    } catch (error) {
      print(error);
    }
  }

  // //! 원래는 cid 보내주는거를 서버쪽에다가 근방 500m 주변에 있는 것들로 보내달라고 해야함. 그렇게 했을때의 조건을 통과하고 그 조건의 cid를 보내는건데 일단은 이렇게 내가 임의로 cid 보내기로 함.
  // todo: 이런식으로 cid 보낸다음에, AR 카메라에서 보이는 캡슐 눌렀을때 cid에 해당하는 CapsuleDetail을 보여주도록 해야함. 이거 json으로 보내는게 맞는거 같음. 리스트로 보내야돼서. 보낼때는 그냥 cid들만 순차적으로 가까운 것들 보내주면 될듯. 그 담에 순차적으로 생성.
  // todo: 아 그리고 나중에 보낼때는 반경 몇 미터 내인지도 보내줘야 할듯. 그래야 순차적으로 유니티에서 필터해서 가까운거부터 앞에 만드는거니까.
  // * FIXME: 아 이게 정적일때는 괜찮은데, 나중에 움직이면서 체크할때는 어떻게 하지 하, 상태변화로 해야될듯? 현재 location 바뀔때마다 하는거루. 그럼 그 때는 init에 넣으면 안될듯?
  // void _initCids() {

  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // sendUnityMessage();
    // print('유니티 초기화 완료');
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _unityWidgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityCreated: onUnityCreated,
      onUnityMessage: onUnityMessage,
    );
  }
}

// 6월25일 면접 준비했어요 .. 오늘도 넘어갈게요 하핳 