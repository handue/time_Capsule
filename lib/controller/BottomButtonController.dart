import 'package:get/get.dart';
import 'package:time_capsule/screen/GroupPage.dart';
import 'package:time_capsule/screen/HomeScreen.dart';
import 'package:time_capsule/screen/MapPage.dart';
import 'package:time_capsule/screen/MyPage.dart';

class BottomButtonController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void onTap(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 0) {
      Get.off(() => HomeScreen());
    } else if (selectedIndex.value == 1) {
      Get.off(() => GroupPage());
    } else if (selectedIndex.value == 2) {
      Get.to(() => MapPage());
    } else if (selectedIndex.value == 3) {
      Get.off(() => MyPage());
    }
  }
}
