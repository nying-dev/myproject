import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectTab = widget.selectedTab;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.lightGreen.withOpacity(0.17),
                spreadRadius: 10.0,
                blurRadius: 28.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: "assets/images/tab_home.png",
            selected: _selectTab == 0 ? true : false,
            onTap: () => {widget.tabPressed(0)},
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_category.png",
            selected: _selectTab == 1 ? true : false,
            onTap: () => {print(_selectTab), widget.tabPressed(1)},
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_notif.png",
            selected: _selectTab == 2 ? true : false,
            onTap: () => {print(_selectTab), widget.tabPressed(2)},
          ),
          BottomTabBtn(
            imagePath: "assets/images/tab_profile.png",
            selected: _selectTab == 3 ? true : false,
            onTap: () => {print(_selectTab), widget.tabPressed(3)},
          )
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;
  BottomTabBtn({this.imagePath, this.selected, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 6),
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(
            // ignore: deprecated_member_use
            color:
                selected ? Theme.of(context).accentColor : Colors.transparent,
            width: 2,
          ),
        )),
        child: Image(
          image: AssetImage(imagePath),
          width: 29.0,
          height: 24.0,
          color: selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
