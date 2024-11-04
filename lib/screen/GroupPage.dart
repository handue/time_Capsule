import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/screen/NotificationPage.dart';

class GroupPage extends StatelessWidget {
  GroupPage({super.key});

  final BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  final PostController postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(context, width, height),
            _buildGroupInfo(width, height),
            _buildLatestPosts(width, height),
            _buildPostList(width, height),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(width),
    );
  }

  Widget _buildAppBar(BuildContext context, double width, double height) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: false,
      pinned: true,
      elevation: 0,
      toolbarHeight: height * 0.08,
      leadingWidth: width * 0.5,
      title: _buildGroupTitle(context, width),
      actions: [
        _buildAddMemberButton(context),
        _buildNotificationButton(),
      ],
    );
  }

  Widget _buildGroupTitle(BuildContext context, double width) {
    return Row(
      children: [
        Text(
          '용인팟',
          style: TextStyle(
            fontSize: width * 0.04,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () => _showMembersDialog(context, width),
          child: Text(
            '그룹멤버: 5',
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: width * 0.03,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddMemberButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.group_add, color: Colors.black),
      onPressed: () => _showAddMemberDialog(context),
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      icon: const Icon(Icons.notifications_none, color: Colors.black),
      onPressed: () => Get.to(Notificationpage()),
    );
  }

  Widget _buildGroupInfo(double width, double height) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildGroupImage(width, height),
            SizedBox(height: height * 0.02),
            Text(
              '용인대 최고의 파티, 용인팟',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: width * 0.05),
            ),
            Text(
              '파티코드: 123456',
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(height: height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 16),
                Text(
                  '주활동지: 경기도 용인시 처인구',
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            const Text(
                '어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구어쩌구저쩌구'),
            SizedBox(height: height * 0.02),
            Text(
              '생성일자: 2024년 4월 28일',
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupImage(double width, double height) {
    return Container(
      width: width * 0.8,
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLatestPosts(double width, double height) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.03),
        child: Text(
          '용인팟의 최신글',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 0.05,
          ),
        ),
      ),
    );
  }

  Widget _buildPostList(double width, double height) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildPostItem(width, height),
        childCount: 1,
      ),
    );
  }

  Widget _buildPostItem(double width, double height) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.black),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostImages(width, height),
          _buildPostContent(width),
          _buildPostActions(width),
        ],
      ),
    );
  }

  Widget _buildPostImages(double width, double height) {
    return SizedBox(
      height: height * 0.25,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(3, (index) => _buildPostImage(width, height)),
      ),
    );
  }

  Widget _buildPostImage(double width, double height) {
    return Container(
      width: width * 0.6,
      margin: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostContent(double width) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'zzuntekk',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.04),
              ),
              SizedBox(width: width * 0.02),
              Text(
                '용인팟',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: width * 0.03),
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16),
              Text(
                '서울시 강서구에서',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: width * 0.03),
              ),
            ],
          ),
          SizedBox(height: width * 0.02),
          const Text(
            'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActions(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildActionButton(CupertinoIcons.heart, '13', width),
        _buildActionButton(CupertinoIcons.chat_bubble, '13', width),
        _buildActionButton(CupertinoIcons.share, '13', width),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String count, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        children: [
          Icon(icon, color: Colors.black, size: width * 0.06),
          Text(count, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(double width) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: Colors.grey)),
      ),
      child: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: width * 0.07,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
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
          onTap: bottomButtonController.onTap,
        ),
      ),
    );
  }

  void _showMembersDialog(BuildContext context, double width) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('그룹 멤버'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) => _buildMemberItem(width)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMemberItem(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: Row(
        children: [
          CircleAvatar(
            radius: width * 0.05,
            backgroundImage: const AssetImage('images/profile.png'),
          ),
          SizedBox(width: width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'zzuntekk',
                style: TextStyle(
                    fontSize: width * 0.04, fontWeight: FontWeight.bold),
              ),
              Text(
                '홍준택',
                style: TextStyle(fontSize: width * 0.03),
              ),
            ],
          ),
          const Spacer(),
          const Icon(CupertinoIcons.person_solid, color: Colors.yellow),
        ],
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('그룹 멤버 추가'),
          content: const TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: "닉네임 입력",
              border: OutlineInputBorder(),
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
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }
}
