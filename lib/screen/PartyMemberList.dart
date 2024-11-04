import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/widget/WidgetTools.dart';

class PartyMemberList extends StatelessWidget {
  PartyMemberList({super.key});
  PostController postController = Get.find<PostController>();

  // cid, pid 받아서 작동하는 부분 작성

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            // 다이얼로그의 크기를 최소화하여 컨텐츠에 맞게 조절
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        CupertinoIcons.xmark,
                        size: width * 0.075,
                        color: Colors.black,
                      )),
                  Text(
                    '파티 멤버:5',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const PartyMemberCard(
                imagePath:
                    '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                nickname: 'handue',
                role: '파티장',
                iconColor: Colors.yellow, // 아이콘 색깔을 yellow로 설정
              ),
              const PartyMemberCard(
                imagePath:
                    '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                nickname: 'handue',
                role: '파티원',
                iconColor: Colors.black, // 아이콘 색깔을 yellow로 설정
              ),
              const PartyMemberCard(
                imagePath:
                    '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                nickname: 'handue',
                role: '파티원',
                iconColor: Colors.black, // 아이콘 색깔을 yellow로 설정
              ),
              const PartyMemberCard(
                imagePath:
                    '/Users/zzuntekk/time_Capsule-main/images/basketball.png',
                nickname: 'handue',
                role: '파티원',
                iconColor: Colors.black, // 아이콘 색깔을 yellow로 설정
              ),
            ],
          ),
        ),
      ),
    );
  }
}