import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/screen/HomeScreen.dart';
import 'package:time_capsule/widget/ShowDialog.dart';

void main() {
  runApp(const MyApp());
  Get.lazyPut(() => LocationController());
  Get.lazyPut(() => PostController());
  Get.lazyPut(() => BottomButtonController());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  //이제 get.find 할 때마다 if(locationController != null)을 해주면 될듯, 경우에 따라 try Catch 문도 괜춘
  //getFind해서 인스턴스 못 찾았을 때 showdialog 띄울 때는 try catch로 따로 구문 주는게 나은듯

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      print("기기 위치 설정 안됐음");
    }

    permission = await Geolocator.checkPermission();

    // if (permission == LocationPermission.always ||
    //     permission == LocationPermission.whileInUse) {}

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {}

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // return Future.error('Location permissions are denied');
        print("권한 허락 안했음");
        ShowDialog.showCustomDialog('위치 접근');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'hi',
      home: HomeScreen(),
    );
  }
}
