import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/CapsuleController.dart';
import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/model/CapsuleModel.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({super.key});
  PostController postController = Get.find<PostController>();
  PhotoController photoController = Get.find<PhotoController>();
  CapsuleController capsuleController = Get.find<CapsuleController>();
  LocationController locationController = Get.find<LocationController>();

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
                        ),
                      ),
                    ),
                    onPressed: () {
                      // TODO: 캡슐 정보들 다 받아와서 서버로 넘겨주는거 해야되는데 지금은 일단 생략
                      // var newCapsule = CapsuleModel(
                      //     partyName: partyName,
                      //     title: postController.postTitle.value,
                      //     contents: postController.postText.value,
                      //     latitude: latitude,
                      //     longitude: longitude,
                      //     locationName: postController.postLocation.value,
                      //     createdAt: DateTime.now().toIso8601String(),
                      //     image: ,
                      //     like: 0,
                      //     nickname: nickname,
                      //     capsuleLike: capsuleLike,
                      //     capsuleComment: capsuleComment);
                      // CapsuleController.sendCapsule();

                      //* FIXME: 지금은 내가 임의로 입력값 넣어줘서 캡슐 만들고, 그거를 작성하기 눌렀을 때, 구글맵에 만들어지도록 해야할듯.
                      // ! 구글맵에 만들어지도록은 했늗네, 나중에 입력값은 서버로부터 받아오도록 하거나 입력값 직접 프론트에서 받고 그걸 서버로 넘겨주고 구글맵에 캡슐 만들도록 해야할듯.
                      //*  5월 14일 cid 일단 5로 임시로 냈음. 그래야 구분할수 있으니께

                      capsuleController.newCapsule.value = CapsuleModel(
                        cid: 5,
                        partyName: "준택이와친구들",
                        title: "암온어준택",
                        contents: "홍준택은 ..",
                        latitude: 37.272206,
                        longitude: 127.056204,
                        locationName: "준택이 마음속..",
                        createdAt: DateTime.now(),
                        updatedAt: '',
                        image: 'images/background.png',
                        like: 3,
                        nickname: '홍준택탈모',
                        capsuleLike: false,
                        capsuleComment: ['홍준택 폼 미쳤다', '홍준택 그냥 미쳤다'],
                      );
                      print("새로운 캡슐 ${capsuleController.newCapsule.value}");
                      capsuleController.capsuleList
                          .add(capsuleController.newCapsule.value);
                      print("캡슐컨트롤러 캡슐 리스트: ${capsuleController.capsuleList}");

                      locationController.createCapsuleMarkers(
                          capsuleController.capsuleList.value);

                      // TODO: 음 이제 캡슐 생성까지 완료했으니까, 이거 구글맵으로 이동시킨 다음에 구글맵에서 터치 했을때 캡슐 정보 뜨게 해야할듯.
                      // TODO: 흠.. 이거를 이제 구글맵으로 넘겨줘서 구글맵에서 그림 그리도록 해야되는데 흐으으음..
                      // TODO: 5월 13일, 위에거 전부 다 구현했음.  이제 해야될거는 내 근방에 있는 캡슐들을 거리순으로 AR 카메라에 뜨게 하고, AR카메라에서도 캡슐 눌렀을 때 캡슐에 대한 정보 뜨도록 하는거. 그러려면 카메라 버튼 눌렀을때, 현재 위치 보내주고 현재 위치 주변 500m내에 있는 캡슐들 카메라에 뜨게 해줘야할듯. 그래서 지금은 카메라 버튼 눌렀을때 이용될 함수를 만들어야함.

                      // ! 5월14일
                      //FIXME: 캡슐컨트롤러의 cid를 유니티로 넘기는게 안됨. 근데 그냥 숫자 3 넘겼을때도 유니티에서 받기는 하는데, 캡슐 생성을 못하는거 보니까 유니티랑 플러터 둘 다에 문제 있는듯.

                      // capsuleController.nearCapsuleList
                      //     .assign(capsuleController.newCapsule.value);
                      // print(
                      //     ' 새로운 캡슐: ${capsuleController.newCapsule.value!.cid}');
                      // print(
                      //     ' 주변 캡슐 리스트 : ${capsuleController.nearCapsuleList.value}');
                      // print('ㅎㅇ');
                      // print(
                      //     '메시지 보낼거 0번 인덱스: ${capsuleController.nearCapsuleList.value[0]?.cid ?? ''}');
                      // for (int i = 0;
                      //     i < capsuleController.nearCapsuleList.value.length;
                      //     i++) {
                      //   print(
                      //       '메시지 반복문으로 보낼거: ${capsuleController.nearCapsuleList.value[i]?.cid}');
                      // }
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '게시글 수정',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.05),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.03, vertical: height * 0.005),
                    child: SizedBox(
                      height: width * 0.4,
                      child: ListView(
                        //좀더 자연스럽게 구현
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                // Todo: 이거 내가 핸드폰에서 직접 가져온 사진을 나중엔 캡슐로 올릴수 있도록 해야함. 그리고 이거 가져온 사진들에 따라서 규격 늘어나도록 해야할듯
                                image: AssetImage("images/background.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: width * 0.01,
                          // ),
                          // Container(
                          //   width: width * 0.4,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     image: const DecorationImage(
                          //       image: AssetImage("images/background.png"),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: width * 0.01,
                          // ),
                          // Container(
                          //   width: width * 0.4,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(20),
                          //     image: const DecorationImage(
                          //       image: AssetImage("images/background.png"),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      photoController.imagePick();
                                    },
                                    icon: const Icon(Icons.add_a_photo),
                                    label: const Text('사진 추가하기')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextField(
                    onChanged: (val) {
                      postController.postTitle.value = val;
                    },
                    maxLines: 1,
                    minLines: 1, // 이거 textField 기본 height 값 늘리는 방법
                    decoration: const InputDecoration(
                      labelText: '위치 입력',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextField(
                    onChanged: (val) {
                      postController.postLocation.value = val;
                    },
                    maxLines: 1,
                    minLines: 1, // 이거 textField 기본 height 값 늘리는 방법
                    decoration: const InputDecoration(
                      labelText: '위치 입력',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextField(
                    onChanged: (val) {
                      postController.postText.value = val;
                    },
                    maxLines: 8,
                    minLines: 8, // 이거 textField 기본 height 값 늘리는 방법
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
