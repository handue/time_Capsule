import 'package:flutter/material.dart';

enum Options { search, notification, setting, logout }

Color black = Colors.black;

class dropDownWidget extends StatelessWidget {
  dropDownWidget({super.key});

  var popupMenuItemIndex = 0;
  String currentPage = 'Home';

  @override
  Widget build(BuildContext context) {
    return buildAppBarWidget();
  }

  buildAppBarWidget() {}

  static PopupMenuItem buildPopupMenuItemWidget(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: black,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(color: black),
          ),
        ],
      ),
    );
  }

  onMenuItemSelected(int Value) {}
}
