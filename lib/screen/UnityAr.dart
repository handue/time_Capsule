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
  late UnityWidgetController _unityWidgetController;
  LocationController locationController = Get.find<LocationController>();

  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  void getCurrentPosition() {}

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
