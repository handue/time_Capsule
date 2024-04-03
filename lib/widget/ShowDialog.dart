import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowDialog {
  static void showCustomDialog(String stuff) {
    Get.dialog(AlertDialog(
      title: const Text('권한 요청'),
      content: Text('이 기능을 사용하기 위해서는 $stuff권한이 필요합니다.'),
      actions: <Widget>[
        TextButton(
          child: const Text('닫기'),
          onPressed: () => Get.back(),
        ),
        TextButton(
            onPressed: () => openAppSettings(), child: const Text('설정으로 이동'))
      ],
    ));
  }
}
