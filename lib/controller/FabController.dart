import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

const Duration _duration = Duration(milliseconds: 275);

class FabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool open = false.obs;

  late AnimationController _controller;
  late Animation<double> expandAnimation;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    try {
      _controller = AnimationController(
          value: open.value ? 0.0 : 1.0, duration: _duration, vsync: this);
      expandAnimation =
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    } catch (e) {
      throw Exception('fabcontroller 오류');
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _controller.dispose();
  }

  void toggle() {
    open.value = !open.value;

    if (open.value) {
      _controller.forward(); //애니메이션 재생 하는거
    } else {
      _controller.reverse();
    }
  }
}
