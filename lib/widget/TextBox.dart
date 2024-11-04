import 'package:flutter/material.dart';

class textBox extends StatelessWidget {
  final Color tcolor;
  final String boxText;
  final double size;
  final String? htext;

  const textBox({
    super.key,
    required this.tcolor,
    required this.boxText,
    required this.size,
    this.htext,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: boxText,
        hintText: htext,
        labelStyle: TextStyle(
          color: tcolor,
          fontSize: size,
        ),
      ),
    );
  }
}