import 'package:geolocator/geolocator.dart';

class CapsuleModel {
  late int? cid;
  final String partyName;
  final String title;
  final String contents;
  final double latitude;
  final double longitude;
  final String locationName;
  final DateTime createdAt;
  late DateTime? updatedAt;
  // late String image;
  final dynamic image;
  //! FIXME: 이거 나중에 dynamic이 아니라 string으로 바꿔야함. 이미지는 그냥 내가 임의로 실험하려고 dynamic으로 했음.
  final int like;
  final String nickname;
  final bool capsuleLike;
  late List<dynamic> capsuleComment;

  CapsuleModel({
    this.cid,
    required this.partyName,
    required this.title,
    required this.contents,
    required this.latitude,
    required this.longitude,
    required this.locationName,
    required this.createdAt,
    String? updatedAt,
    required this.image,
    //! FIXME: 이거 나중에 dynamic이 아니라 string으로 바꿔야함. 이미지는 그냥 내가 임의로 실험하려고 dynamic으로 했음.
    required this.like,
    required this.nickname,
    required this.capsuleLike,
    required this.capsuleComment,
  });

  // ! Json은 키 값이 항상 String임

  Map<String, dynamic> toJson() => {
        'cid': cid,
        'partyName': partyName,
        'title': title,
        'contents': contents,
        'latitude': latitude,
        'longitude': longitude,
        'locationName': locationName,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'image': image,
        'like': like,
        'nickname': nickname,
        'capsuleLike': capsuleLike,
        'capsuleComment': capsuleComment,
      };

  CapsuleModel.fromJson(Map<String, dynamic> json)
      : cid = json['cid'],
        partyName = json['partyName'],
        title = json['title'],
        contents = json['contents'],
        latitude = json['location']['latitude'].toDouble(),
        longitude = json['location']['longitude'].toDouble(),
        locationName = json['locationName'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']),
        image = json['image'],
        like = json['like'],
        nickname = json['nickname'],
        capsuleLike = json['capsuleLike'],
        capsuleComment = List<dynamic>.from(json['capsuleComment']);
}
