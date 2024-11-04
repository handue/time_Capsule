import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_capsule/controller/CapsuleController.dart';
import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:intl/intl.dart';

class CapsuleDetail extends StatelessWidget {
  CapsuleDetail({Key? key}) : super(key: key);

  final CapsuleController capsuleController = Get.find<CapsuleController>();

  void capsuleOntap(CapsuleModel capsule) {
    print('테스트 캡슐 터치!');
    capsuleController.capsuleContents.value = capsule.contents;
    
    capsuleController.capsuleLike.value = capsule.like;
    capsuleController.capsuleLocationName.value = capsule.locationName;
    capsuleController.capsuleTitle.value = capsule.title;
    capsuleController.capsuleParty.value = capsule.partyName;
    capsuleController.capsuleNickname.value = capsule.nickname;
    capsuleController.capsuleCreatedTime.value =
        DateFormat('yyyy-MM-dd HH:mm').format(capsule.createdAt);
    Get.to(() => CapsuleDetail());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;
    final double height = screenSize.height;

    return Scaffold(
      appBar: _buildAppBar(width, height),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCapsuleContent(width, height),
                SizedBox(height: height * 0.02),
                _buildInteractionButtons(width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double width, double height) {
    return AppBar(
      toolbarHeight: height * 0.065,
      leading: IconButton(
        icon: Icon(CupertinoIcons.xmark, size: width * 0.075, color: Colors.black54),
        onPressed: () => Get.back(),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.photo, size: width * 0.07),
          onPressed: () {
            // Handle photo action
          },
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.03),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            ),
            onPressed: () => Get.back(),
            child: Text('수정', style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }

  Widget _buildCapsuleContent(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(width),
            SizedBox(height: height * 0.02),
            _buildImageGallery(width, height),
            SizedBox(height: height * 0.02),
            _buildUserInfo(width),
            SizedBox(height: height * 0.01),
            _buildLocation(width),
            SizedBox(height: height * 0.02),
            _buildCapsuleText(width),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${capsuleController.capsuleTitle}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.05),
        ),
        SizedBox(height: width * 0.01),
        Text(
          '${capsuleController.capsuleCreatedTime}',
          style: TextStyle(color: Colors.black54, fontSize: width * 0.035),
        ),
      ],
    );
  }

  Widget _buildImageGallery(double width, double height) {
    return SizedBox(
      height: height * 0.25,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildImageItem(width, height, capsuleController.newCapsule.value?.image ?? "images/testpic.png"),
          // Add more images here if needed
        ],
      ),
    );
  }

  Widget _buildImageItem(double width, double height, String imagePath) {
    return Container(
      width: width * 0.7,
      margin: EdgeInsets.only(right: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: imagePath.startsWith('images/') 
              ? AssetImage(imagePath) as ImageProvider  // 기본 이미지일 경우
              : FileImage(File(imagePath)) as ImageProvider,  
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUserInfo(double width) {
    return Row(
      children: [
        Text(
          '${capsuleController.capsuleNickname}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),
        ),
        SizedBox(width: width * 0.02),
        Text(
          '${capsuleController.capsuleParty}',
          style: TextStyle(color: Colors.black54, fontSize: width * 0.035),
        ),
      ],
    );
  }

  Widget _buildLocation(double width) {
    return Row(
      children: [
        Icon(Icons.location_on, size: width * 0.04, color: Colors.black54),
        SizedBox(width: width * 0.01),
        Text(
          '${capsuleController.capsuleLocationName}',
          style: TextStyle(color: Colors.black54, fontSize: width * 0.035),
        ),
      ],
    );
  }

  Widget _buildCapsuleText(double width) {
    return Text(
      '${capsuleController.capsuleContents}',
      style: TextStyle(fontSize: width * 0.04),
    );
  }

  Widget _buildInteractionButtons(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildInteractionButton(
          icon: CupertinoIcons.heart,
          label: '${capsuleController.capsuleLike}',
          onPressed: () {
            // Handle like action
          },
          width: width,
        ),
        SizedBox(width: width * 0.04),
        _buildInteractionButton(
          icon: CupertinoIcons.chat_bubble,
          label: '3',
          onPressed: () {
            // Handle comment action
          },
          width: width,
        ),
      ],
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required double width,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, size: width * 0.06, color: Colors.black87),
          SizedBox(height: width * 0.01),
          Text(label, style: TextStyle(fontSize: width * 0.035, color: Colors.black87)),
        ],
      ),
    );
  }
}