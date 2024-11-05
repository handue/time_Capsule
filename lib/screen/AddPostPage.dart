import 'dart:io';
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

  final PostController postController = Get.find<PostController>();
  final PhotoController photoController = Get.find<PhotoController>();
  final CapsuleController capsuleController = Get.find<CapsuleController>();
  final LocationController locationController = Get.find<LocationController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(width, height),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPhotoSection(width, height),
                SizedBox(height: height * 0.03),
                _buildTitleField(width),
                SizedBox(height: height * 0.03),
                _buildContentField(width),
                SizedBox(height: height * 0.05),
                _buildSubmitButton(width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double width, double height) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back,
            size: width * 0.06, color: Colors.black54),
        onPressed: () => Get.back(),
      ),
      title: Text(
        '새 게시글 작성',
        style: TextStyle(
          fontSize: width * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.camera,
              size: width * 0.07, color: Colors.black54),
          onPressed: () => photoController.imagePick(),
        ),
      ],
    );
  }

  Widget _buildPhotoSection(double width, double height) {
    return Container(
      height: height * 0.25,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAddPhotoButton(width, height),
          SizedBox(width: width * 0.02),
          Obx(() => Row(
                children: photoController.userMedia
                    .map((file) => _buildPhotoPreview(file, width, height))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildAddPhotoButton(double width, double height) {
    return Container(
      width: height * 0.25,
      margin: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: InkWell(
        onTap: () => photoController.imagePick(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo,
                size: width * 0.08, color: Colors.blue[600]),
            SizedBox(height: height * 0.01),
            Text('사진 추가',
                style: TextStyle(
                    color: Colors.blue[600], fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPreview(dynamic file, double width, double height) {
    return Container(
      width: height * 0.25,
      margin: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: FileImage(File(file.path)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitleField(double width) {
    return TextField(
      controller: titleController,
      onChanged: (val) => postController.postText.value = val,
      style: TextStyle(fontSize: width * 0.045),
      decoration: InputDecoration(
        labelText: '제목',
        hintText: '제목을 입력하세요',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        prefixIcon: const Icon(Icons.title, color: Colors.blue),
      ),
    );
  }

  Widget _buildContentField(double width) {
    return TextField(
      controller: contentController,
      onChanged: (val) => postController.postText.value = val,
      maxLines: 8,
      style: TextStyle(fontSize: width * 0.04),
      decoration: InputDecoration(
        labelText: '내용',
        hintText: '게시글 내용을 입력하세요',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        prefixIcon: const Icon(Icons.article, color: Colors.blue),
      ),
    );
  }

  // Widget _buildLocationField(double width) {
  //   return TextField(
  //     readOnly: true,
  //     onTap: () {
  //       // Handle location selection
  //     },
  //     decoration: InputDecoration(
  //       labelText: '위치',
  //       hintText: '위치를 선택하세요',
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(15),
  //         borderSide: const BorderSide(color: Colors.blue, width: 2.0),
  //       ),
  //       prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
  //       suffixIcon: Icon(Icons.arrow_forward_ios,
  //           color: Colors.blue, size: width * 0.04),
  //     ),
  //   );
  // }

  Widget _buildSubmitButton(double width) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
      ),
      onPressed: _handleComplete,
      child: Text(
        '게시하기',
        style: TextStyle(
          fontSize: width * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleComplete() {
    String imagePath = 'images/testpic.png';

    if (photoController.userMedia.isNotEmpty) {
      imagePath = photoController.userMedia.first.path;
    }
    print('ImagePath : $imagePath');
    // * 플러터에서 userMedia[0] 이랑 userMedia.first랑 같지만, 후자가 좀 더 명확한 에러 메시지를 제공한다

    capsuleController.newCapsule.value = CapsuleModel(
      cid: 5,
      partyName: "준택이와친구들",
      title: titleController.text,
      contents: contentController.text,
      latitude: 37.228425,
      longitude: 127.167643,
      locationName: "용인",
      createdAt: DateTime.now(),
      updatedAt: '',
      image: imagePath,
      like: 0,
      nickname: '홍준택탈모',
      capsuleLike: false,
      capsuleComment: ['홍준택 폼 미쳤다', '홍준택 그냥 미쳤다'],
    );

    capsuleController.capsuleList.add(capsuleController.newCapsule.value);
    locationController
        .createCapsuleMarkers(capsuleController.capsuleList.value);
    capsuleController.nearCapsuleList
        .assign(capsuleController.newCapsule.value);

    photoController.userMedia.clear();

    Get.back();
  }
}
