import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/CapsuleController.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/screen/AddPostPage.dart';

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

  void searchCapsule() {
    //위도 경도 DB로 보내기만 하면 알아서 주변 컨텐츠들은 가져올 수 있음.
    // 그러니까 그냥 db로 현재 내 위치 보내는것만 하면 될듯.
    locationController.currentPosition.value?.longitude;
    locationController.currentPosition.value?.latitude;
  }

  void onUnityMessage(message) {
    if (message == "addPost") {
      Get.to(() => AddPostPage());
    }
  }
  // ! 5월14일 유니티 수신 오류
  // FIXME: 유니티로 메시지 전송은 되는데, 유니티에서 수신이 안됨. 

  void sendUnityMessage() {
    for (int i = 0; i < capsuleController.nearCapsuleList.value.length; i++) {
      _unityWidgetController.postMessage(
          'UnityMessageReceiver',
          'receiveMessage',
          '${capsuleController.nearCapsuleList.value[i]?.cid}');
      print('유니티 메시지 전송 완료');
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
