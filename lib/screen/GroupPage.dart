import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';

class GroupPage extends StatelessWidget {
  GroupPage({super.key});
  BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
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
                    'Group',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              actions: [
                Icon(Icons.search, size: width * 0.083),
                const Padding(padding: EdgeInsets.only(right: 8)),
                Icon(Icons.menu, size: width * 0.09),
                const Padding(padding: EdgeInsets.only(right: 10)),
              ],
            ),
            SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: 20, (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: index == 0
                          ? const Border(top: BorderSide.none)
                          : Border.all(
                              color: const Color.fromARGB(255, 200, 196, 196),
                              width: 0.7)),
                  child: ListTile(
                    title: Text('Group${index + 1}'),
                    subtitle: const Text('this is subtitle'),
                    trailing: const Icon(Icons.group_add),
                    leading: Container(
                      width: width * 0.1,
                      height: height * 0.046,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(150)),
                      child: Icon(
                        CupertinoIcons.group_solid,
                        size: width * 0.08,
                      ),
                    ),
                    // leading: const Image(
                    //   image: AssetImage('images/profile.png'),
                    // ),
                  ),
                );
              }),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: height * 0.075,
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
