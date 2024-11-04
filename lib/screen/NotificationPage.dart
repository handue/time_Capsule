import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PostController.dart';

class Notificationpage extends StatelessWidget {
  Notificationpage({super.key});
  BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  PostController postController = Get.find<PostController>();
  final ValueNotifier<bool> showFirstScreen = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // SliverFillRemaining 나중에 이거 함 써봐도 좋을듯
              automaticallyImplyLeading: false,
              // expandedHeight: 200,
              toolbarHeight: height * 0.08,
              leadingWidth: width * 0.5,
              floating: false,
              // 스크롤 다시 올리면 appbar 보이게 하는거
              snap: false,
              // floating이 활성화 된 순간에 스크롤 멈추는 순간 appbar의 전부를 불러오도록 함.
              pinned: true,
              // 항상 appBar 표시. 기본값은 false인데 이 경우엔 스크롤 올릴떄만 가능.
              //surfaceTintColor:
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.white,
                  // color: const Color.fromARGB(255, 231, 228, 228),
                ),
              ),
              // flexibleSpace 이거 사용하면 스크롤 다시 올릴 때 appbar색 이상하지 않고 계속 하얀색임. 뭐 동적으로 움직일 때나, 가장 위로 스크롤 했을 때 스크롤 바 색 바꿔주려고
              //  사용한다는데, 일단은 flexibleSpace 안 썻을 때, 스크롤 색이 일반 배경 색이랑 안 맞고 약간 분홍색이라 색 지정하려고 해줬음.
              shape: const Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5)),
              leading: Row(children: [
                SizedBox(width: width * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          CupertinoIcons.back,
                          size: width * 0.075,
                          color: Colors.black,
                        )),
                    Text(
                      '알림',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            SliverPadding(
              padding: EdgeInsets.all(width * 0.02),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              // 아래쪽 테두리
                              color: Colors.grey, // 테두리 색상
                              width: 1.0, // 테두리 두께
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.03),
                            const Text(
                              '용인팟',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Card(
                                    shadowColor: Colors.white,
                                    elevation: 5,
                                    clipBehavior: Clip.antiAlias,
                                    shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50), // 원하는 둥글기
                                        side: const BorderSide(
                                            width: 1, color: Colors.black)),
                                    child: SizedBox(
                                      width: width * 0.15,
                                      height: width * 0.15,
                                      child: const Image(
                                        image: AssetImage('images/profile.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  SizedBox(
                                    width: width * 0.6,
                                    child: const Text(
                                      '축하합니다! 용인팟의 파티장이 되셨습니다!',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              // 아래쪽 테두리
                              color: Colors.grey, // 테두리 색상
                              width: 1.0, // 테두리 두께
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.03),
                            const Text(
                              '베스킷볼 프렌즈',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Card(
                                    shadowColor: Colors.white,
                                    elevation: 5,
                                    clipBehavior: Clip.antiAlias,
                                    shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50), // 원하는 둥글기
                                        side: const BorderSide(
                                            width: 1, color: Colors.black)),
                                    child: SizedBox(
                                      width: width * 0.15,
                                      height: width * 0.15,
                                      child: const Image(
                                        image: AssetImage(
                                            '/Users/zzuntekk/time_Capsule-main/images/basketball.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  SizedBox(
                                    width: width * 0.6,
                                    child: const Text(
                                      '배스킷볼 프렌즈의 파티장이 김인수님으로 임명되었습니다.',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}