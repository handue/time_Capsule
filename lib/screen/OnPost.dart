import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/widget/WidgetTools.dart';

class OnPost extends StatelessWidget {
  OnPost({super.key});
  PostController postController = Get.find<PostController>();
  PhotoController photoController = Get.put(PhotoController());
  final Stream<int> _autoScrollStream = (() {
    StreamController<int> controller = StreamController<int>();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      controller.add(timer.tick);
    });
    return controller.stream;
  })();

  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);
  final int _widgetCount = 3;
  final PageController _pageController = PageController();
  final ValueNotifier<int> likeCount = ValueNotifier<int>(0);
  // cid, pid 받아서 작동하는 부분 작성
  AutoScrollWidget() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _currentIndexNotifier.value =
          (_currentIndexNotifier.value + 1) % _widgetCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: height * 0.065,
          leadingWidth: width * 0.8,
          backgroundColor: Colors.white,
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    size: width * 0.075,
                    color: Colors.black54,
                  )),
              Text(
                'zzuntekk님의 게시글',
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: const []),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      const Text(
                        '풋살은 즐거워',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.4,
                          width: width * 0.9,
                          child: StreamBuilder<int>(
                            stream: _autoScrollStream,
                            builder: (context, snapshot) {
                              return MyPageView(
                                imagePaths: const [
                                  '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                                  '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                                  '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                                  '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                                  '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      const Text(
                        'zzuntekk',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          const Text(
                            '경기도 용인시',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          const Text(
                            '2024.05.11',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            likeCount.value++;
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 5),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.heart,
                                color: Colors.white,
                                size: width * 0.062,
                              ),
                              ValueListenableBuilder<int>(
                                valueListenable: likeCount,
                                builder: (context, value, child) {
                                  return Text(
                                    '$value', // 좋아요 수
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const Text(
                      '개레전드 경기... 오늘만 벌써 3골을 넣었다... 하지만 졌다... 다음번엔 꼭이긴다...',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
              /* Container(
                width: width * 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text(
                    '최신댓글 보기',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Comment(
                    imagePath: 'images/profile.png',
                    nickname: 'handue',
                    commentText: '니 한골도 못넣었잖아;;',
                  ),
                  const Comment(
                    imagePath: 'images/profile.png',
                    nickname: 'handue',
                    commentText: '니 한골도 못넣었잖아;;',
                  ),
                ]),
              ),*/
            ],
          ),
        ),
      ))),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: height * 0.06, // 텍스트 입력 필드의 높이 조정
                    child: const Align(
                      alignment: Alignment.centerLeft, // TextField를 왼쪽으로 정렬
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "댓글 입력하기...",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        maxLength: 200,
                        maxLines: 2, // 단일 라인 입력으로 변경
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // 댓글 전송 기능 구현
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}