import 'dart:ui';

import 'package:get/get.dart';

class PostModel {
  String name;
  String context;
  String date;
  // List<Image>? image;// 지금은 단일 이미지에 리스트 형식으로 api 작성한것도 아니라 나중에 수정해줘야함
  String? image;
  int? pid; // 게시글 번호 같은거 걍 id라고 보면 됨'
  String? location;

  PostModel(
      {required this.name,
      required this.context,
      required this.date,
      this.pid,
      this.image,
      this.location});

  PostModel.fromJson(Map<String, dynamic> json)
      : context = json['content'],
        name = json['user'],
        date = json['date'],
        pid = json['id'],
        image = json['image'];
}
