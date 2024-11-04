import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class partyButton extends StatelessWidget {
  final String imagePath;
  final String text;

  const partyButton({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return TextButton(
      onPressed: () {
        // 버튼 클릭 시 동작 정의
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shadowColor: Colors.white,
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(50), // 둥근 모서리
              side: const BorderSide(width: 1, color: Colors.black),
            ),
            child: SizedBox(
              width: width * 0.18,
              height: width * 0.18,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.15,
            child: Text(
              text, // 전달된 텍스트 표시
              style: const TextStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis, // 텍스트가 길 경우 '...'으로 표시
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class postWidget extends StatelessWidget {
  final String imagePath;
  final String nickname;
  final String location;
  final String date;
  final String content;
  final VoidCallback? onCommentPressed;

  final ValueNotifier<int> likeCount = ValueNotifier<int>(0);

  postWidget({
    super.key,
    required this.imagePath,
    required this.nickname,
    required this.location,
    required this.date,
    required this.content,
    this.onCommentPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      width: width * 0.9,
      height: height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: width * 0.9,
              height: height * 0.3,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(
                    nickname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black54,
                    ),
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
                      onPressed: onCommentPressed,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 3),
                      ),
                      child: Icon(
                        CupertinoIcons.chat_bubble,
                        color: Colors.white,
                        size: width * 0.062,
                      ),
                    ),
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
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.02,
              ),
              SizedBox(
                width: width * 0.85,
                child: Text(
                  content, // 전달된 텍스트 표시
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis, // 텍스트가 길 경우 '...'으로 표시
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PartyMemberCard extends StatelessWidget {
  final String imagePath; // 사진 경로
  final String nickname; // 닉네임 텍스트
  final String role; // 역할 (파티원/파티장)
  final Color iconColor;

  const PartyMemberCard({
    super.key,
    required this.imagePath,
    required this.nickname,
    required this.role,
    this.iconColor = Colors.black, // 기본값은 검정색
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Icon(
          CupertinoIcons.person_2,
          color: iconColor,
          size: width * 0.05,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Card(
          shadowColor: Colors.white,
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(50), // 원하는 둥글기
            side: const BorderSide(width: 1, color: Colors.black),
          ),
          child: SizedBox(
            width: width * 0.18,
            height: width * 0.18,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: width * 0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nickname,
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  role,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class Comment extends StatelessWidget {
  final String imagePath; // 사진 경로
  final String nickname; // 닉네임
  final String commentText; // 댓글 내용

  const Comment({
    super.key,
    required this.imagePath,
    required this.nickname,
    required this.commentText,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: const CircleBorder(
                side: BorderSide(
                  width: 1,
                ),
              ),
              child: SizedBox(
                width: width * 0.1,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: width * 0.02), // 여백 추가
            Text(
              nickname,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          commentText,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(height: height * 0.02), // Column의 끝부분 여백
      ],
    );
  }
}

class RequestWidget extends StatelessWidget {
  final String imagePath; // 이미지 경로
  final String partyName; // 파티 이름
  final String contentText; // 내용 텍스트

  const RequestWidget({
    super.key,
    required this.imagePath,
    required this.partyName,
    required this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: height * 0.02),
        Text(
          partyName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Card(
                shadowColor: Colors.white,
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // 원하는 둥글기
                  side: const BorderSide(width: 1, color: Colors.black),
                ),
                child: SizedBox(
                  width: width * 0.15,
                  height: width * 0.15,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: width * 0.05),
              SizedBox(
                width: width * 0.6,
                child: Text(
                  contentText,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(width: width * 0.02),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // 버튼 배경색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 버튼 모서리를 둥글게 만듦
                ),
              ),
              child: SizedBox(
                width: width * 0.35,
                height: height * 0.04, // 버튼의 높이 수정
                child: const Center(
                  child: Text(
                    '수락',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.02),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // 버튼 배경색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // 버튼 모서리를 둥글게 만듦
                ),
              ),
              child: SizedBox(
                width: width * 0.35,
                height: height * 0.04, // 버튼의 높이 수정
                child: const Center(
                  child: Text(
                    '거절',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyPageView extends StatelessWidget {
  final List<String> imagePaths;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  MyPageView({super.key, required this.imagePaths});
  final int count = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    int totalPages = imagePaths.length;

    return Stack(children: [
      PageView.builder(
        itemCount: totalPages,
        onPageChanged: (int index) {
          _currentPageNotifier.value = index;
        },
        itemBuilder: (context, index) {
          return Container(
            width: width * 0.9,
            height: height * 0.35,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                ClipRRect(
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                    width: width * 0.9,
                    height: height * 0.38,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      Positioned(
        bottom: 16,
        left: 16,
        right: 16,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7), // 반투명 배경색
              borderRadius: BorderRadius.circular(12), // 둥근 모서리
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, child) {
                return Text(
                  ' ${currentPage + 1} / $totalPages',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // 글자 색상
                  ),
                );
              },
            ),
          ),
        ),
      )
    ]);
  }
}

class onPostWidget extends StatelessWidget {
  final String imagePath;
  final String nickname;
  final String location;
  final String date;
  final String content;
  final VoidCallback? onCommentPressed;

  final ValueNotifier<int> likeCount = ValueNotifier<int>(0);

  onPostWidget({
    super.key,
    required this.imagePath,
    required this.nickname,
    required this.location,
    required this.date,
    required this.content,
    this.onCommentPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Scaffold(
        body: Container(
      width: width * 0.9,
      height: height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: width * 0.9,
              height: height * 0.3,
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Text(
                    nickname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    location,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.black54,
                    ),
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
                      onPressed: onCommentPressed,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(left: 3),
                      ),
                      child: Icon(
                        CupertinoIcons.chat_bubble,
                        color: Colors.white,
                        size: width * 0.062,
                      ),
                    ),
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
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.02,
              ),
              SizedBox(
                width: width * 0.85,
                child: Text(
                  content, // 전달된 텍스트 표시
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis, // 텍스트가 길 경우 '...'으로 표시
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}