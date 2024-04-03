import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/Model/PostModel.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/screen/MapPage.dart';
import 'package:time_capsule/widget/Expandable_fab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  LocationController locationController = Get.find<LocationController>();
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

    return SafeArea(
      child: Scaffold(
        floatingActionButton: ExpandableFab(
          distance: 80.0,
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/background.png"), // 배경 이미지 경로
                fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정
              ),
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
                Icon(Icons.search, size: width * 0.083),
                const Padding(padding: EdgeInsets.only(right: 8)),
                Icon(Icons.menu, size: width * 0.09),
                const Padding(padding: EdgeInsets.only(right: 10)),
              ],
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

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // if (index == 0)
                              //   Container(
                              //     padding: const EdgeInsets.only(left: 25),
                              //     alignment: Alignment.bottomLeft,
                              //     height: height * 0.16,
                              //     color: const Color.fromARGB(255, 212, 164, 164),
                              //   ),
                              const Padding(padding: EdgeInsets.only(top: 25)),
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.5,
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                  borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(20),
                                      right: Radius.circular(20)),
                                ),
                                width: width,
                                height: height * 0.53,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height: height * 0.35,
                                      width: width * 0.9,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        // color: Colors.amber,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(20),
                                            right: Radius.circular(20)),
                                      ),
                                      child: Image.network(
                                        postController.postList[index].image ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5)),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              width: 0.3),
                                        ),
                                      ),
                                      height: height * 0.045,
                                      width: width,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 13),
                                          ),
                                          Transform.translate(
                                            offset: const Offset(0, 2.5),
                                            child: Icon(
                                              CupertinoIcons.heart,
                                              size: width * 0.065,
                                            ),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12)),
                                          Icon(
                                            CupertinoIcons.share,
                                            size: width * 0.062,
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 12)),
                                          Transform.translate(
                                            offset: const Offset(0, 1.1),
                                            child: Icon(
                                              CupertinoIcons.chat_bubble,
                                              size: width * 0.062,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        // color: Colors.amber,
                                        border: Border(
                                            top: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 0.3)),
                                      ),
                                      width: width,
                                      height: height * 0.1,
                                      child: const Padding(
                                        padding: EdgeInsets.all(18),
                                        child: Text('글쓴이(GroupId)'),
                                      ),
                                    ),
                                  ],
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
        // }
        // },
        // ),
        bottomNavigationBar: Container(
          height: height * 0.07,
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
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
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
      ),
    );
  }
}
