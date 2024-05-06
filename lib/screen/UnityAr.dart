import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/LocationController.dart';

class UnityAr extends StatefulWidget {
  const UnityAr({super.key});

  @override
  State<UnityAr> createState() => _UnityArState();
}

class _UnityArState extends State<UnityAr> {
  LocationController locationController = Get.find<LocationController>();
  late UnityWidgetController _unityWidgetController;

  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void searchCapsule() {
    //위도 경도 DB로 보내기만 하면 알아서 주변 컨텐츠들은 가져올 수 있음.
    // 그러니까 그냥 db로 현재 내 위치 보내는것만 하면 될듯.
    locationController.currentPosition.value?.longitude;
    locationController.currentPosition.value?.latitude;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    );
  }
}
