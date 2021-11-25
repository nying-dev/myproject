import 'package:flutter/material.dart';
import 'dart:core';
import 'package:myproject/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final bool isPasswordField;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  Icon icon;
  CustomInput(
      {this.hintText,
      this.isPasswordField,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 24.0,
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: isPasswordField,
        decoration: InputDecoration(
            icon: icon,
            labelText: hintText,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 18.0,
            )),
        style: Constants.kTitleStyle,
      ),
    );
  }
}
