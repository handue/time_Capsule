import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/CapsuleController.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/Model/PostModel.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/screen/LoginPage.dart';
import 'package:time_capsule/screen/MakePartyPage.dart';
import 'package:time_capsule/screen/MapPage.dart';
import 'package:time_capsule/screen/NotificationPage.dart';
import 'package:time_capsule/widget/Expandable_fab.dart';
import 'package:time_capsule/widget/dropDownWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  LocationController locationController = Get.put(LocationController());
  PostController postController = Get.find<PostController>();
  BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  PhotoController photoController = Get.put(PhotoController());

  // initialBinding이 전체 전역에서 사용되는 controller 선언할 때 좋다고 하는데, 아직은 뭔 소린지 모르겠음.

  // 이거 동작 구동을 어떻게 하게 하지, 그냥 모든게 다 승인됐을 때 return map 클래스를 하고 거기서 Geolocator.getCurrentPosition() 을 할까?
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    int likeCount = 0;
    // 검색어를 저장할 변수

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: ExpandableFab(
        distance: 80.0,
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'CapInNet',
                style: TextStyle(
                    fontFamily: 'Kalam',
                    fontSize: width * 0.075,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 53, 68, 80)),
              ),
              // SliverFillRemaining 나중에 이거 함 써봐도 좋을듯
              toolbarHeight: height * 0.08,
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
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              // flexibleSpace 이거 사용하면 스크롤 다시 올릴 때 appbar색 이상하지 않고 계속 하얀색임. 뭐 동적으로 움직일 때나, 가장 위로 스크롤 했을 때 스크롤 바 색 바꿔주려고
              // 사용한다는데, 일단은 flexibleSpace 안 썻을 때, 스크롤 색이 일반 배경 색이랑 안 맞고 약간 분홍색이라 색 지정하려고 해줬음.
              shape: const Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5)),
              // leading: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     child: const FittedBox(child: Icon(Icons.airport_shuttle)),
              //   ),
              // ),
              actions: [
                IconButton(
                  onPressed: () {
                    // Get.to(GetSearchBar(
                    //   isSearchExpanded: false,
                    //   onSearchIconPressed: () {
                    //     // 검색 아이콘 클릭 시 실행될 동작
                    //   },
                    //   onSearchFieldTapped: () {
                    //     Text1();
                    //   },
                    // ));
                  },
                  icon: Icon(
                    Icons.search,
                    size: width * 0.083,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 8)),

                PopupMenuButton(
                  icon: Icon(
                    Icons.menu,
                    size: width * 0.09,
                  ),
                  offset: Offset(width, height * 0.055),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  elevation: 50,
                  itemBuilder: (context) {
                    return [
                      dropDownWidget.buildPopupMenuItemWidget(
                          "설정", Icons.settings, Options.setting.index),
                      dropDownWidget.buildPopupMenuItemWidget(
                          "로그아웃", Icons.logout, Options.logout.index),
                    ];
                  },
                ),

                // Icon(Icons.menu, size: width * 0.09),
                // const Padding(padding: EdgeInsets.only(right: 10)),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: SizedBox(
                          height: width * 0.15,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(MakePartyPage());
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Column의 크기를 최소화하여 아이콘과 텍스트를 세로로 배열
                                    children: [
                                      Icon(Icons.add_box,
                                          size: width * 0.1,
                                          color: Colors.black), // 아이콘 추가
                                      const Text(
                                        '파티 만들기',
                                        style: TextStyle(
                                            color: Colors
                                                .black), // 텍스트 색상을 흰색으로 설정
                                      ), // 텍스트 추가
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.group,
                                          size: width * 0.1,
                                          color: Colors.black),
                                      const Text(
                                        '파티',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.group,
                                          size: width * 0.1,
                                          color: Colors.black),
                                      const Text(
                                        '파티',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.group,
                                          size: width * 0.1,
                                          color: Colors.black),
                                      const Text(
                                        '파티',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.group,
                                          size: width * 0.1,
                                          color: Colors.black),
                                      const Text(
                                        '파티',
                                        style: TextStyle(
                                          color: Colors.black,
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
              ),
            ),
            Obx(() {
              if (postController.postList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.368),
                      const Center(
                        child: CircularProgressIndicator(
                          // 여기서 원래 일반 위젯 circularprogressIndicator 바로 반환했는데, CustomScrollView에서는 반환을 sliver타입으로 해야함. 그래서 일반 위젯을 sliver타입으로 바꿔주는 slivertoboxadapter사용.
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: postController.postList.length,
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
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
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
                                                    0.6, // 이미지의 너비를 화면 너비의 절반으로 설정
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
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              // 버튼이 눌렸을 때 실행되는 코드 작성
                                            },
                                            child: Text(
                                              'zzuntekk',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: width * 0.05),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // 버튼이 눌렸을 때 실행되는 코드 작성
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Text(
                                                  '용인팟',
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontSize: width * 0.035,
                                                  ),
                                                ),
                                              ],
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
                                            onPressed: () {
                                              // 하트 아이콘을 누를 때마다 숫자를 1씩 증가시킵니다.
                                              likeCount++;
                                            },
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  left: 3),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  color: Colors.black,
                                                  CupertinoIcons.heart,
                                                  size: width * 0.065,
                                                ),
                                                Text(
                                                  '$likeCount',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.to(Notificationpage());
                                            },
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.only(
                                                  left: 3),
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
                                            onPressed: () {
                                              Get.to(const LoginPage());
                                            },
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
                  ),
                );
              }
            }),
          ]),
        ]),
      ),
      // }
      // },
      // ),
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
              iconSize: width * 0.05,
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.black,
              currentIndex: bottomButtonController.selectedIndex.value,
              selectedLabelStyle: const TextStyle(color: Colors.black),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), label: 'Group'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on_outlined), label: 'Map'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.profile_circled),
                    label: 'MyPage'),
              ],
              onTap: (index) {
                bottomButtonController.onTap(index);
              } // 아 이 value(지금은 index) 값이 눌렀을 떄 index 제공해주는 값이네

              ,
            );
          },
        ),
      ),
    );
  }

  bool isSearching = false;
  String searchQuery = '';
  Widget buildSearchBar() {
    return isSearching
        ? TextField(
            decoration: const InputDecoration(hintText: '검색어를 입력하세요'),
            onChanged: (value) {
              // 검색어가 변경될 때마다 저장
              searchQuery = value;
            },
          )
        : Container();
  }
}
