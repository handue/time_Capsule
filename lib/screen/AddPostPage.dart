import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:time_capsule/controller/PostController.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({super.key});
  PostController postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.065,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.xmark,
                size: width * 0.075,
                color: Colors.black54,
              )),
          actions: [
            Transform.translate(
              offset: Offset(0, height * 0.0016),
              child: Icon(
                CupertinoIcons.photo,
                size: width * 0.09,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 10),
              child: SizedBox(
                width: width * 0.135,
                height: height * 0.038,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(40),
                          right: Radius.circular(40),
                        ))),
                    onPressed: () {
                      postController.sendData();
                      Get.back();
                    },
                    child: Text(
                      '완료',
                      style: TextStyle(
                          fontSize: width * 0.0353,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 13, right: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (val) {
                      postController.postText.value = val;
                    },
                    maxLines: 15,
                    minLines: 15, // 이거 textField 기본 height 값 늘리는 방법
                    decoration: const InputDecoration(
                      labelText: '글 입력',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: '글을 입력하세요.',
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
