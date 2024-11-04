import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/controller/BottomButtonController.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/screen/CommentScreen.dart';
import 'package:time_capsule/screen/MakePartyPage.dart';
import 'package:time_capsule/screen/OnPost.dart';
import 'package:time_capsule/widget/Expandable_fab.dart';
import 'package:time_capsule/widget/WidgetTools.dart';
import 'package:time_capsule/widget/dropDownWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final LocationController locationController = Get.put(LocationController());
  final PostController postController = Get.find<PostController>();
  final BottomButtonController bottomButtonController =
      Get.find<BottomButtonController>();
  final PhotoController photoController = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: ExpandableFab(distance: 80.0),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(width, height),
            _buildSearchBar(width),
            _buildPartySection(width, height),
            _buildPostList(width, height),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(width),
    );
  }

  Widget _buildAppBar(double width, double height) {
    return SliverAppBar(
      expandedHeight: height * 0.25,
      floating: false,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'CapInNet',
          style: GoogleFonts.poppins(
            fontSize: width * 0.07,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            // Handle notifications
          },
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          itemBuilder: (context) => [
            dropDownWidget.buildPopupMenuItemWidget(
                "설정", Icons.settings, Options.setting.index),
            dropDownWidget.buildPopupMenuItemWidget(
                "로그아웃", Icons.logout, Options.logout.index),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(double width) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: width * 0.03),
            ),
            style: GoogleFonts.roboto(fontSize: width * 0.04),
          ),
        ),
      ),
    );
  }

  Widget _buildPartySection(double width, double height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height * 0.18,
        child: AnimationLimiter(
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.02),
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                _buildPartyButton(
                    icon: Icons.add_box,
                    text: '파티 만들기',
                    onPressed: () => Get.to(MakePartyPage()),
                    width: width),
                _buildPartyButton(
                    icon: Icons.group,
                    text: '파티',
                    onPressed: () {},
                    width: width),
                _buildImagePartyButton('images/travel.png', '용인의 친구들', width),
                _buildImagePartyButton('images/foot.png', '풋살은 즐거워', width),
                _buildImagePartyButton(
                    'images/profile.png', '홍준택을 사랑하는 모임', width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPartyButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required double width,
  }) {
    return Container(
      width: width * 0.28,
      margin: EdgeInsets.only(right: width * 0.03),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          shadowColor: Colors.blue.withOpacity(0.3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: width * 0.08, color: Colors.blue[700]),
            SizedBox(height: width * 0.01),
            Text(
              text,
              style: GoogleFonts.roboto(
                  color: Colors.blue[700],
                  fontSize: width * 0.03,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePartyButton(String imagePath, String text, double width) {
    return Container(
      width: width * 0.28,
      margin: EdgeInsets.only(right: width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: width * 0.07,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: width * 0.01),
          Text(
            text,
            style: GoogleFonts.roboto(
                color: Colors.blue[700],
                fontSize: width * 0.03,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPostList(double width, double height) {
    return Obx(() {
      if (postController.postList.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(color: Colors.blue[700]),
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildPostItem(width, height),
                  ),
                ),
              );
            },
            childCount: 3,
          ),
        );
      }
    });
  }

  Widget _buildPostItem(double width, double height) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.04, vertical: width * 0.02),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(width * 0.03),
            leading: CircleAvatar(
              radius: width * 0.06,
              backgroundImage: const AssetImage('images/foot.png'),
            ),
            title: Text(
              '풋살은 즐거워의 최신글',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold, fontSize: width * 0.045),
            ),
            subtitle: Text(
              'insu_1004 • 경기도 용인시 • 2024.05.11',
              style: GoogleFonts.roboto(
                  fontSize: width * 0.03, color: Colors.grey[600]),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Handle more options
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.02),
            child: Text(
              '오늘 한골 넣었다 기분 짱 좋다 한번더 도전해서 3골 넣어봐야징',
              style: GoogleFonts.roboto(fontSize: width * 0.04),
            ),
          ),
          Image.asset(
            'images/foot.png',
            fit: BoxFit.cover,
            height: height * 0.25,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildInteractionButton(
                        Icons.favorite_border, '24', Colors.red),
                    SizedBox(width: width * 0.04),
                    _buildInteractionButton(
                        Icons.comment, '5', Colors.blue[700]!),
                  ],
                ),
                _buildInteractionButton(Icons.share, '공유', Colors.green),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: width * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      hintStyle: GoogleFonts.roboto(fontSize: width * 0.035),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: width * 0.02),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue[700]),
                  onPressed: () {
                    // Handle comment submission
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(text, style: GoogleFonts.roboto(color: color, fontSize: 14)),
      ],
    );
  }

  Widget _buildBottomNavigationBar(double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue[700],
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.roboto(),
          currentIndex: bottomButtonController.selectedIndex.value,
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
}
