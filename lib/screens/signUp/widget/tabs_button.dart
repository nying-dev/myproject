import 'package:flutter/cupertino.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:myproject/widget/bottom_tabs.dart';

class TopTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  TopTabs({this.selectedTab, this.tabPressed});

  @override
  _TopTabsState createState() => _TopTabsState();
}

class _TopTabsState extends State<TopTabs> {
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
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TopTabBtn(
          selected: _selectTab == 0 ? true : false,
          onTap: () => {widget.tabPressed(0)},
        ),
        TopTabBtn(
          selected: _selectTab == 1 ? true : false,
          onTap: () => {widget.tabPressed(1)},
        ),
      ]),
    );
  }
}

class BtnNext extends StatelessWidget {
  final VoidCallback onPressed;
  final String textBtn;
  final Function(String) onSubmitted;

  BtnNext({this.onPressed, this.textBtn, this.onSubmitted});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          child: Center(
            child: Text(
              textBtn,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          padding: EdgeInsets.only(left: 8),
          height: 30.0,
          width: 100,
          decoration: BoxDecoration(color: Colors.green),
        ));
  }
}

class TopTabBtn extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  TopTabBtn({this.selected, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 6),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            // ignore: deprecated_member_use
            color:
                selected ? Theme.of(context).accentColor : Colors.transparent,
            width: 10,
          ),
        )),
      ),
    );
  }
}
