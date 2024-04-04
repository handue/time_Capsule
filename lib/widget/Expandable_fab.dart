import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/FabController.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/controller/PostController.dart';
import 'package:time_capsule/screen/AddPostPage.dart';
import 'package:time_capsule/screen/ArCamera.dart';

const Duration _duration = Duration(milliseconds: 275);

class ExpandableFab extends StatelessWidget {
  ExpandableFab({
    super.key,
    required this.distance,
    // required this.children,
  });

  double distance;
  // List<Widget> children;
  // List<_ExpandableActionButton> aniChildren = [];

  // List<_ExpandableActionButton> buttonChildren() {
  //   final int count = children.length;
  //   final double gap = 90.0 / (count);
  //   for (var i = 0, degree = 0.0; i < count; i++, degree += gap) {
  //     aniChildren.add(_ExpandableActionButton(
  //         distance: distance,
  //         degree: degree,
  //         progress: fabController.expandAnimation,
  //         child: children[i]));
  //   }

  //   return aniChildren;
  // }

  FabController fabController = Get.put(FabController());

  // late AnimationController _controller;

  // late Animation<double> _expandAnimation;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Obx(() {
      return SizedBox.expand(
        child: Stack(alignment: Alignment.bottomRight, children: [
          _ExpandableActionButton(
            distance: distance,
            degree: 0.0,
            progress: fabController.expandAnimation,
            child: ActionButton(
              opacity: fabController.open.value ? 1.0 : 0,
              color: Colors.black,
              onPressed: () {
                Get.to(() => AddPostPage());
                // Get.to(page) 게시글
              },
              icon: const Icon(Icons.edit,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          _ExpandableActionButton(
            distance: distance,
            degree: 45.0,
            progress: fabController.expandAnimation,
            child: ActionButton(
              opacity: fabController.open.value ? 1.0 : 0,
              color: Colors.black,
              onPressed: () async {
                PhotoController photoController = Get.find<PhotoController>();
                photoController.imagePick();

                // Get.to() 갤러리 들어가는거
              },
              icon: const Icon(CupertinoIcons.photo,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          _ExpandableActionButton(
            distance: distance,
            degree: 90.0,
            progress: fabController.expandAnimation,
            child: ActionButton(
              opacity: fabController.open.value ? 1.0 : 0,
              color: Colors.black,
              onPressed: () {
                PhotoController photoController = Get.find<PhotoController>();
                // photoController.cameraPick();
                Get.to(() => const ArCamera());

                // Get.to() 카메라 들어가는거
              },
              icon: const Icon(CupertinoIcons.camera_fill,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          AnimatedContainer(
            duration: _duration,
            transformAlignment: Alignment.center,
            transform: Matrix4.rotationZ(fabController.open.value ? pi / 2 : 0),
            child: AnimatedOpacity(
              duration: _duration,
              opacity: fabController.open.value ? 1.0 : 0.8,
              child: FloatingActionButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                backgroundColor:
                    fabController.open.value ? Colors.black : Colors.white,
                onPressed: fabController.toggle,
                elevation: 0,
                child: Icon(
                  Icons.add,
                  color: fabController.open.value ? Colors.white : Colors.black,
                  size: fabController.open.value ? width * 0.089 : width * 0.08,
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.color,
      required this.opacity});

  final VoidCallback onPressed;
  final Widget icon;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: _duration,
      opacity: opacity,
      child: Material(
        shape: const CircleBorder(),
        color: color,
        elevation: 0,
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _ExpandableActionButton extends StatelessWidget {
  const _ExpandableActionButton(
      {super.key,
      required this.distance,
      required this.degree,
      required this.progress,
      required this.child});
  final double distance;
  final double degree; // 각도 설정해서 어디에 놓을지 정하는거. 3방향으로 하잖음.
  final Animation<double> progress; // 0.1~1.0으로 움직임 진행도 나타냄. 0.1이면 10퍼
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      child: child,
      builder: (context, child) {
        // 여기서 받는 child 인자는 위에 있는 child임
        final Offset offSet = Offset.fromDirection(
            degree *
                (pi /
                    180) // 이게 라디안으로 변환하는 거라는데 90도를 라디안으로 변환하려면 90*(pi/180) 이래. 솔직히 뭔소린지 모르겠음 ㅋㅋ
            // pi가 1파이잖아, 전체 원이 360도 그게 2파이. 180도가 1파이지.
            // 근데 pi/180 이 뭔데, 라디안 변환 식인가? 아 맞네 라디안 변환 식이네. 여기서 degree가 받는 각도, 그 이후 각도를 라디안으로 변환
            // 라디안이 파이로 원 지름 계산하는거 같은데,
            // 그래서 라디안으로는 변환을 왜 하는가? 여기서 라디안으로 방향을 측정한대. 즉 direction이 측정되는걸 라디안으로 한다네
            // progress.value * distance는 0.1~1.0 진행도에 distance곱하는건데 진행도에 따라 distance 곱해서 offset의 위치를 설정하는 거래
            ,
            progress.value * distance);
        return Positioned(
          right: offSet.dx + 3.5, // 오른쪽으로부터 얼마만큼 띄워놓는다.
          bottom: offSet.dy + 2.5,
          child: child!,
        );
      },
    );
  }
}
