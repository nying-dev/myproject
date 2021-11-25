import 'package:flutter/material.dart';

class MQuery {
  static double width = 0.0;
  static double height = 0.0;

  void init(BuildContext context) {
    final MediaQueryData _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
  }
}
