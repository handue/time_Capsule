import 'package:geolocator/geolocator.dart';

class CapsuleModel {
  late int cid;
  late String partyName;
  late String title;
  late String contents;
  late double latitude;
  late double longitude;
  late String locationName;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String image;
  late int like;
  late String nickname;
  late bool capsuleLike;
  late List<dynamic> capsuleComment;

  CapsuleModel({
    int? cid,
    required String partyName,
    required String title,
    required String contents,
    required double latitude,
    required double longitude,
    required String locationName,
    required String createdAt,
    String? updatedAt,
    required String image,
    required int like,
    required String nickname,
    required bool capsuleLike,
    required List capsuleComment,
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
