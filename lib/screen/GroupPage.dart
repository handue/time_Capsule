import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/screen/NotificationPage.dart';

class GroupPage extends StatelessWidget {
  GroupPage({super.key});
  BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  PostController postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
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
                leading: Row(
                  children: [
                    SizedBox(width: width * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '용인팟',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              barrierColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('그룹 멤버'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // 다이얼로그의 크기를 최소화하여 컨텐츠에 맞게 조절
                                      children: [
                                        Row(
                                          children: [
                                            Card(
                                              shadowColor: const Color.fromARGB(
                                                  255, 147, 167, 242),
                                              elevation: 3,
                                              clipBehavior: Clip.antiAlias,
                                              shape: const CircleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: width * 0.08,
                                                height: height * 0.08,
                                                child: const Image(
                                                  image: AssetImage(
                                                      'images/profile.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'zzuntekk',
                                                  style: TextStyle(
                                                    fontSize: width * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '홍준택',
                                                  style: TextStyle(
                                                    fontSize: width * 0.02,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            const Icon(
                                              CupertinoIcons.person_solid,
                                              color: Colors.yellow,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Card(
                                              shadowColor: const Color.fromARGB(
                                                  255, 147, 167, 242),
                                              elevation: 3,
                                              clipBehavior: Clip.antiAlias,
                                              shape: const CircleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: width * 0.08,
                                                height: height * 0.08,
                                                child: const Image(
                                                  image: AssetImage(
                                                      'images/profile.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'zzuntekk',
                                                  style: TextStyle(
                                                    fontSize: width * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '홍준택',
                                                  style: TextStyle(
                                                    fontSize: width * 0.02,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Card(
                                              shadowColor: const Color.fromARGB(
                                                  255, 147, 167, 242),
                                              elevation: 3,
                                              clipBehavior: Clip.antiAlias,
                                              shape: const CircleBorder(
                                                side: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: width * 0.08,
                                                height: height * 0.08,
                                                child: const Image(
                                                  image: AssetImage(
                                                      'images/profile.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: width * 0.02),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'zzuntekk',
                                                  style: TextStyle(
                                                    fontSize: width * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '홍준택',
                                                  style: TextStyle(
                                                    fontSize: width * 0.02,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('닫기'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.all(8.0), // 버튼의 padding 조정
                            child: Text(
                              '그룹멤버: 5',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: width * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('그룹 멤버 추가'),
                            content: const TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "닉네임 입력",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              maxLength: 16,
                              maxLines: 1,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('추가'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('닫기'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.group_add,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(Notificationpage());
                    },
                    child: const Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(),
                sliver: SliverToBoxAdapter(
                  child: Container(
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
                        SizedBox(
                          height: height * 0.02,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          height: height * 0.35,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.0, color: Colors.white),
                              image: const DecorationImage(
                                image: AssetImage("images/background.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '용인대 최고의 파티, 용인팟',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.05),
                        ),
                        Text(
                          '파티코드: 123456', //위치값 받기
                          style: TextStyle(
                            color: const Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(0.5),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                            ),
                            Text(
                              '주활동지: 경기도 용인시 처인구', //위치값 받기
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              '어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구'),
                        ),
                        Text(
                          '생성일자: 2024년 4월 28일',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        '용인팟의 최신글',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        // 화면 전체 박스
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: height * 0.02)),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.5, color: Colors.black),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 0,
                                        blurRadius: 5.0,
                                        offset: Offset(0,
                                            10), // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.01,
                                          vertical: height * 0.01,
                                        ),
                                        child: SizedBox(
                                          height: height * 0.3,
                                          width: width * 0.9,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: <Widget>[
                                              Container(
                                                width: width *
                                                    0.5, // 이미지의 너비를 화면 너비의 절반으로 설정
                                                height: height *
                                                    0.15, // 이미지의 높이를 화면 높이의 40%로 설정
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "images/background.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              Container(
                                                width: width *
                                                    0.5, // 이미지의 너비를 화면 너비의 절반으로 설정
                                                height: height *
                                                    0.15, // 이미지의 높이를 화면 높이의 40%로 설정
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "images/background.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                              Container(
                                                width: width *
                                                    0.5, // 이미지의 너비를 화면 너비의 절반으로 설정
                                                height: height *
                                                    0.15, // 이미지의 높이를 화면 높이의 40%로 설정
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "images/background.png"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.01,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              // 버튼이 눌렸을 때 실행되는 코드 작성
                                            },
                                            child: Text(
                                              'zzuntekk',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // 버튼이 눌렸을 때 실행되는 코드 작성
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                '용인팟',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.03,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // 버튼이 눌렸을 때 실행되는 코드 작성
                                            },
                                            child: Text(
                                              '서울시 강서구에서.', //위치값 받기
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.03),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.005),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', //글 내용
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  color: Colors.black,
                                                  CupertinoIcons.heart,
                                                  size: width * 0.065,
                                                ),
                                                const Text(
                                                  '13',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  color: Colors.black,
                                                  CupertinoIcons.chat_bubble,
                                                  size: width * 0.062,
                                                ),
                                                const Text(
                                                  '13',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  color: Colors.black,
                                                  CupertinoIcons.share,
                                                  size: width * 0.062,
                                                ),
                                                const Text(
                                                  '13',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      );
                    },
                    childCount: 1, // SliverList에는 하나의 자식만 필요합니다.
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: Obx(
          () {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              iconSize: width * 0.07, // 아이콘 크기 증가
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.blueAccent,
              currentIndex: bottomButtonController.selectedIndex.value,
              selectedLabelStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: width * 0.035,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                color: Colors.grey,
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
              ),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
                BottomNavigationBarItem(icon: Icon(Icons.group), label: '파티'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on_outlined), label: '맵'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled), label: '마이'),
              ],
              onTap: (index) {
                bottomButtonController.onTap(index);
              },
            );
          },
        ),
      ),
    );
  }
}
