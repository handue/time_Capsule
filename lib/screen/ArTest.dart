import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

//현재 위치를 기반으로 좌표 찍고 AR 넣으려면 AR KIT보다는 unity 사용해야 되는거 같음.. 힘들더라도 그쪽 방향으로 가야하는데 내일까지 정보 더 찾아보고
// 없으면 그냥 UNITY 해야할듯
//현재 유니티 하고 있는데 계속 의문이 있음, 결국 자세한 좌표로 찍는게 불가능하면 flutter 통해서 animate 되는지만 확인해보면 되는거 아닌가?
//유니티를 굳이 해야하나? 라는 생각이 존재. 내일까지 정해보기로 했음
// 유니티로 하는중, 유니티로 하는게 맞는거 같음 flutter로 했을 때 차후 업데이트에 분명 한계가 있을거라고 판단 + 깔끔한 기능 위해선 유니티 하는게 맞는듯
// 유니티 본격 1일차 4.10

class ArTest extends StatefulWidget {
  const ArTest({super.key});

  @override
  _ArTest createState() => _ArTest();
}

class _ArTest extends State<ArTest> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Container(
              child: ARKitSceneView(
                showFeaturePoints: true,
                planeDetection: ARPlaneDetection.horizontal,
                onARKitViewCreated: onARKitViewCreated,
              ),
            ),
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arkitController.onAddNodeForAnchor = (anchor) {
      _handleAddAnchor(anchor, 'models.scnassets/dash/dash.dae');
      // _handleAddAnchor(anchor, 'models.scnassets/heart/12190_Heart_v1_L3.obj');
    };
  }

  void _handleAddAnchor(ARKitAnchor anchor, String url) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor, url);
    }
  }

  void _addPlane(
      ARKitController controller, ARKitPlaneAnchor anchor, String url) {
    if (node != null) {
      controller.remove(node!.name);
    }
    node = ARKitReferenceNode(
      url: url,
      //need to bring some dae
      scale: vector.Vector3.all(0.1),
    );
    controller.add(node!, parentNodeName: anchor.nodeName);
  }
}
