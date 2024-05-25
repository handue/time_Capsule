import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:time_capsule/screen/JoinPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08, vertical: height * 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'CapInNet',
                    style: TextStyle(
                        fontFamily: 'Kalam',
                        fontSize: width * 0.075,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 53, 68, 80)),
                  ),
                  Text(
                    '소중한 나의 추억 저장소',
                    style: TextStyle(
                        fontFamily: 'Kalam',
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  /* SizedBox(height: height * 0.05),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '아이디',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '비밀번호',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 버튼이 클릭되었을 때 수행할 작업
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 버튼 배경색 설정
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: width * 0.3,
                          height: height * 0.06,
                          child: const Center(
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(JoinPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // 버튼 배경색 설정
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: width * 0.3,
                          height: height * 0.06,
                          child: const Center(
                            child: Text(
                              '회원가입',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      // 버튼이 클릭되었을 때 수행할 작업
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 버튼 배경색 설정
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: width * 0.5,
                      height: height * 0.06,
                      child: const Center(
                        child: Text(
                          '구글 계정으로 로그인하기',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
