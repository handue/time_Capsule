import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class ArCamera extends StatefulWidget {
  const ArCamera({super.key});

  @override
  State<ArCamera> createState() => _ArCameraState();
}

class _ArCameraState extends State<ArCamera> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated)),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final node = ARKitNode(
        geometry: ARKitSphere(radius: 0.1), position: math.Vector3(0, 0, -0.5));
    this.arkitController.add(node);
  }
}
