import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:time_capsule/controller/LocationController.dart';
import 'package:time_capsule/controller/PhotoController.dart';
import 'package:time_capsule/model/CapsuleModel.dart';
import 'package:time_capsule/screen/UnityAr.dart';
import 'package:time_capsule/widget/customMarker.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final LocationController locationController = Get.find<LocationController>();

  // void _onMapCreated(GoogleMapController controller) {
  //   locationController.mapController = controller;
  //   // 초기 위치를 가져오거나 설정
  //   if (locationController.currentPostion.value != null) {
  //     locationController
  //         .updateCameraPosition(locationController.currentPostion.value!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.camera_on_rectangle_fill,
                size: width * 0.1,
              ),
              onPressed: () {
                // PhotoController photoController = Get.find<PhotoController>();
                // photoController.cameraPick();
                Get.to(() => const UnityAr());
                // todo: 그리고 음, 근방 캡슐 가져오도록 서버에 요청해야 하는데, 지금은 서버가 안 되니까 일단은 보류하고 다르게 해야할듯. 그러려면 일단 캡슐 내가 임의로 작성한거 넘겨주고 그거 눌렀을때 유니티에서 플러터 capsule detail 오픈하도록 해야겠다. 


                // FIXME:  이때 cid 넘겨줘야할듯. 지금 그냥 unityar들어가는건 잘 되는데,
              },
            )
          ],
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                size: width * 0.085,
              ))),
      body: Obx(() {
        return GoogleMap(
          // onTap: (latLng){
          //   CapsuleModel touchedCapsule =
          // },
          markers: Set<Marker>.from(locationController.userMarkers.value
              .union(locationController.capsuleMarkers.value)),
          circles: {
            Circle(
              circleId: const CircleId("1"),
              // 이거 나중에 CircleId를 회원 ID 유니크 값이랑 같도록 해야될듯.
              center: LatLng(locationController.currentPosition.value!.latitude,
                  locationController.currentPosition.value!.longitude),
              radius: 100,
              fillColor: Colors.blueAccent.withOpacity(0.1),
              strokeColor: Colors.blueAccent,
              strokeWidth: 2,
            )
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: locationController.onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              locationController.currentPosition.value!.latitude,
              locationController.currentPosition.value!.longitude,
            ),
            zoom: 16.0,
          ),
          onCameraMove: (CameraPosition position) {
            locationController.onCameraMove(position);
          },
        );
      }),
      floatingActionButton: SizedBox(
        width: width * 0.13,
        height: height * 0.0601,
        child: FloatingActionButton(
          splashColor: const Color.fromARGB(255, 202, 201, 201),
          focusColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(80))),
          backgroundColor: Colors.white,
          onPressed: () {
            locationController.getLocationUpdates();
            locationController.updateCameraPosition(
                locationController.currentPosition.value!);
            // print(locationController.currentPosition.value);
            // print(locationController.currentPosition.value?.latitude);
            // print(locationController.currentPosition.value?.longitude);
            // 이게 현재 에뮬레이터ㅔㅇ선 location을 얻을 수가 없어서, postion 이 null처리 되는데, 그럼 동작하는지 확인 못 하니까 updateCameraPostion 넣어줌. 나중엔 뺴야함.
          },
          child: Icon(Icons.my_location_outlined,
              size: width * 0.058,
              color: const Color.fromARGB(255, 88, 88, 88)),
          // label: const Text(''),
          // icon: const Icon(
          //   Icons.my_location_outlined,
          //   color: Color.fromARGB(255, 88, 88, 88),
          // ),
        ),
      ),
    );
  }
}
