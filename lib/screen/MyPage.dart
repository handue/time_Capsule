import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});
  BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    var textWidth = width * 0.05;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
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
                Icon(Icons.menu, size: width * 0.09),
                const Padding(padding: EdgeInsets.only(right: 10)),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                child: Column(
                  children: [
                    Card(
                      shadowColor: const Color.fromARGB(255, 147, 167, 242),
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      shape: const CircleBorder(
                          side: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 147, 167, 242))),
                      child: SizedBox(
                        width: width * 0.85,
                        height: height * 0.42,
                        child: const Image(
                          image: AssetImage('images/profile.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: const Color.fromARGB(255, 189, 201, 247),
                height: height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            '1',
                            style: TextStyle(fontSize: textWidth),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 0)),
                          Text('팔로워',
                              style: TextStyle(
                                  fontSize: textWidth,
                                  fontFamily: 'SingleDay')),
                        ],
                      ),
                      Column(children: [
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text('1', style: TextStyle(fontSize: textWidth)),
                        Text('팔로잉',
                            style: TextStyle(
                                fontSize: textWidth, fontFamily: 'SingleDay')),
                      ]),
                      Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          Text('1',
                              style: TextStyle(
                                fontSize: textWidth,
                              )),
                          Text(
                            '게시글',
                            style: TextStyle(
                                fontSize: textWidth, fontFamily: 'SingleDay'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(padding: EdgeInsets.all(15)),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.1,
                              color: const Color.fromARGB(255, 188, 188, 188))),
                      child: Image.asset('images/loading.png'));
                },
                childCount: 20,
              ),
            )
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: height * 0.075,
          // decoration: const BoxDecoration(
          //   border: Border(
          //     top: BorderSide(width: 0.5, color: Colors.grey),
          //   ),
          // ),
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
