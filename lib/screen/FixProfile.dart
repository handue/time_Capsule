import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PostController.dart';

class FixProfile extends StatelessWidget {
  FixProfile({super.key});
  BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  PostController postController = Get.find<PostController>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // SliverFillRemaining 나중에 이거 함 써봐도 좋을듯
              automaticallyImplyLeading: false,
              // expandedHeight: 200,
              toolbarHeight: height * 0.055,
              leadingWidth: width * 0.2,
              floating: true,
              // 스크롤 다시 올리면 appbar 보이게 하는거
              snap: true,
              // floating이 활성화 된 순간에 스크롤 멈추는 순간 appbar의 전부를 불러오도록 함.
              pinned: false,
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
              leading: Row(
                children: [
                  SizedBox(width: width * 0.03),
                  Text(
                    'MyPage',
                    style: TextStyle(
                      fontSize: width * 0.041,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      CupertinoIcons.back,
                      size: width * 0.075,
                      color: Colors.black,
                    )),
                SizedBox(
                  height: height * 0.02,
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                      right: Radius.circular(20),
                    ),
                    border: Border(
                      bottom: BorderSide(
                          width: 0.3,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    shadowColor: Colors.white,
                                    elevation: 5,
                                    clipBehavior: Clip.antiAlias,
                                    shape: const CircleBorder(
                                        side: BorderSide(
                                            width: 1, color: Colors.white)),
                                    child: SizedBox(
                                      width: width * 0.35,
                                      height: height * 0.19,
                                      child: const Image(
                                        image: AssetImage('images/profile.png'),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('늘렀음');
                                    },
                                    child: Container(
                                      width: width * 0.35,
                                      height: height * 0.19,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: width * 0.1,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            '사진 변경',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: height * 0.08, // 텍스트 입력 필드의 높이 조정

                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "현재 닉네임 표시가능하면?",
                                labelText: '닉네임 변경',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.0),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              maxLength: 20,
                              maxLines: 1, // 단일 라인 입력으로 변경
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.03),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '중복확인',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "현재 이름 표시가능하면?",
                        labelText: '이름 변경',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      maxLength: 10,
                      maxLines: 1, // 단일 라인 입력으로 변경
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: ElevatedButton(
          onPressed: () {
            Get.to(FixProfile());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // 버튼 배경색 설정
          ),
          child: SizedBox(
            width: width * 0.3,
            height: height * 0.06,
            child: const Center(
              child: Text(
                '프로필 수정',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
