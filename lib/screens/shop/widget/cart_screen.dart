import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      ),
    );
  }
}
