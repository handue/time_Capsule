import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:time_capsule/widget/ShowDialog.dart';

class PhotoController extends GetxController with WidgetsBindingObserver {
  ImagePicker picker = ImagePicker();
  RxList<XFile> userMedia = <XFile>[].obs;

  Future<void> imagePick() async {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      List<XFile> images = await picker.pickMultipleMedia();
      userMedia.assignAll(images);
    } else {
      ShowDialog.showCustomDialog('갤러리 접근');
    }
  }

  Future<void> cameraPick() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      XFile? video = await picker.pickVideo(source: ImageSource.camera);
      if (image != null) {
        userMedia.add(image);
      }
      if (video != null) {
        userMedia.add(video);
      }
    } else {
      ShowDialog.showCustomDialog('카메라 접근');
    }
  }
}
