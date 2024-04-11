import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityAr extends StatefulWidget {
  const UnityAr({super.key});

  @override
  State<UnityAr> createState() => _UnityArState();
}

class _UnityArState extends State<UnityAr> {
  late UnityWidgetController _unityWidgetController;

  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityCreated: onUnityCreated,
    );
  }
}
