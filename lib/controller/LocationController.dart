import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:time_capsule/screen/CapsuleDetail.dart';
import 'package:time_capsule/widget/customMarker.dart';

class LocationController extends GetxController {
  // CapsuleController capsuleController = Get.find<CapsuleController>();
  Rx<Position?> currentPosition = Rx<Position?>(null);
  StreamSubscription<Position>? positionStreamSubscription;

  Rx<BitmapDescriptor?> markerIcon =
      Rx<BitmapDescriptor?>(BitmapDescriptor.defaultMarker);

  RxSet<Circle> circle = RxSet();

  RxSet<Marker> userMarkers = RxSet();
  RxSet<Marker> capsuleMarkers = RxSet();

  CapsuleDetail capsuleDetail = CapsuleDetail();

  double currentZoom = 18.0;

  var userColor = Colors.blue;
  var userBorderColor = Colors.white;
  var capsuleColor = Colors.purple;
  // Rx을 통해서 변화 관찰하도록 하는것, null값 가능, position 에 대한 객체에 대해.
  GoogleMapController? mapController;
  // 이거 있어야 맵 컨트롤 된다네, 아래랑 같이 외워둬야 할듯, void 쓰는 이유는 객체로 주려면 어차피 이렇게 해야됨.
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 5, // 5미터 움직일때마다 정보 업데이트하기.
  );

  void onCameraMove(CameraPosition position) {
    currentZoom = position.zoom;
  }

  void updateCameraPosition(Position position) {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: currentZoom,
    )));
  }

  getLocationUpdates() async {
    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      currentPosition.value = position;
      print(currentPosition.value);
      addUserMarker('images/profile.png', position);
    });
  }

  // ! 이거 내가 임의로 설정한 custom Marker넣는 코드

  Future<void> addCapsuleMarker(String address) async {
    final Marker capsuleMarker = Marker(
      position: const LatLng(37.268950, 127.056357),
      markerId: const MarkerId('2'),
      icon: await customMarker.getMarkerIcon(
          imagePath: address,
          size: const Size(125.0, 125.0),
          mainColor: capsuleColor,
          borderColor: userBorderColor),
    );
    capsuleMarkers.assign(capsuleMarker);
  }

  // ! FIXME: 이거 나중에 다 수정해야함. 지금은 임의로 값 넣은값 찾아서 게시글 보여주도록 하는거임. 위에 addCapsuleMarker로 만든거는 터치해도 아무것도 안된다잉.

  // void capsuleOntap(CapsuleModel capsule) {
  //   print('테스트 캡슐 터치!');
  //   // todo: 나중에는 capsule의 아이디 찾아서 페이지 보여주도록 해야할듯. 일단은 제목이나 내용 같은 것들 다 CapsuleController에다가 박아놓음
  //   capsuleController.capsuleContents.value = capsule.contents;
  //   capsuleController.capsuleLike.value = capsule.like;
  //   capsuleController.capsuleLocationName.value = capsule.locationName;
  //   capsuleController.capsuleTitle.value = capsule.title;
  //   capsuleController.capsuleParty.value = capsule.partyName;
  //   capsuleController.capsuleNickname.value = capsule.nickname;
  //   capsuleController.capsuleCreatedTime.value =
  //       capsule.createdAt.toIso8601String();
  //   Get.to(() => CapsuleDetail());
  // }

  Future<void> testCapsuleMarker(CapsuleModel capsule, int i) async {
    final Marker capsuleMarker$i = Marker(
      onTap: () => capsuleDetail.capsuleOntap(capsule),
      // ! FIXME: 나중엔 MarkerId 어차피 자동으로 백에서 값 올려줘서 굳이 i 안 넣어도 되는데 지금은 그냥 테스트 차원에서 넣음.

      position: LatLng(capsule.latitude, capsule.longitude),
      markerId: MarkerId("$i"),
      icon: await customMarker.getMarkerIcon(
          imagePath: capsule.image,
          size: const Size(125.0, 125.0),
          mainColor: capsuleColor,
          borderColor: userBorderColor),
    );
    capsuleMarkers.add(capsuleMarker$i);
  }

  Future<void> createCapsuleMarkers(List<CapsuleModel?> capsuleList) async {
    for (int i = 0; i <= capsuleList.length; i++) {
      int j = 3;
      if (capsuleList[i] != null) {
        await testCapsuleMarker(capsuleList[i]!, j);
      }
      j++;
    }
  }

  Future<void> addUserMarker(String address, Position position) async {
    // final markerIcon =
    //     await customMarker.getMarkerIcon(address, const Size(150.0, 150.0));
    final Marker userMarker = Marker(
        position: LatLng(currentPosition.value?.latitude ?? position.latitude,
            currentPosition.value?.longitude ?? position.longitude),
        markerId: const MarkerId('1'),
        icon: await customMarker.getMarkerIcon(
            imagePath: address,
            size: const Size(125.0, 125.0),
            mainColor: userColor,
            borderColor: userBorderColor));

    userMarkers.assign(userMarker);
    // 이거 add로 했었는데, add로 하면 여지껏 움직였던 좌표 달라질 때마다 Set이 인식하기엔 중복하는 거로 인식을 하질 못 해서
    // 여러개가 찍히더라. 근데 setState나 obx 안해놔서 화면 뒤로 갔다가 다시 하기로 했을 때 이 문제가 발견됐음.
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocationUpdates();
    addCapsuleMarker('images/capsule.png');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    positionStreamSubscription?.cancel();
  }

  // 동작 구동 1. 컨트롤러 초기화시에 getLocationUpdates 통해서 locationSetting 해주고, 현재 위치를 가져옴. currentPosition값에 현재 position 넣어주고, position이 널이 아니면
  // updateCamera통해서 현재 포지션 값 받고, map 컨트롤러로 animateCamera해서 CameraUpdate.newCamearPostion~~ 이거 해줘서 위치 바꿔줌 .
  // 근데 지금 핸드폰에는 위치 서비스 따로 없어서 null 값 들어갈거임. 그래서 핸드폰으로 확인해봐야함
  // 비동기 -> 데이터 크기 큰거 같을때, 될떄까지 내비두고 다음으로 가는건데, 현재 위치는 동기로 처리하는게 맞는거 같은게, 이거 바로 안 되면 의미가 없음
}
