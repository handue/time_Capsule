import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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
