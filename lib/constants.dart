import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color kPrimaryColor = Color(0xff53B175);
final Color kShadowColor = Color(0xffA8A8A8);
const Color kBlackColor = Color(0xff181725);
const Color kSubtitleColor = Color(0xff7C7C7C);
final Color kSecondaryColor = Color(0xffffffff);
final Color kBorderColor = Color(0xffE2E2E2);

class Constants {
  static const regularHeading = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black);
  static const boldHeading = TextStyle(
      fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.black);
  static const regularDarkText = TextStyle(
      fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black);
  static const kTitleStyle = TextStyle(
      fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff181725));
  static const kDescriptionStyle =
      TextStyle(color: kSubtitleColor, fontSize: 13);
}
