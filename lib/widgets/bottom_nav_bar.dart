import 'package:flutter/material.dart';

import '../config/constants.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(IconData(0xe627, fontFamily: 'MyIcons')), label: "主页"),
        BottomNavigationBarItem(
            icon: Icon(IconData(0xe7b6, fontFamily: 'MyIcons')), label: "饮品"),
        BottomNavigationBarItem(
            icon: Icon(IconData(0xe601, fontFamily: 'MyIcons')), label: "订单"),
      ],
      currentIndex: _currentIndex,
      fixedColor: kActiveIconColor,
      onTap: (index) =>
          setState(() {
            _currentIndex = index;
          }),);
  }
}
