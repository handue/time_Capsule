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

// 시험공부 있어서 커밋 대충 했어요. 봐주세요 시험공부 끝나고 열심히 코딩할게요 ㅠㅜㅠㅜ
