import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myproject/constants.dart';
import 'dart:core';

class CustomBtn extends StatefulWidget {
  final String textBtn;
  final VoidCallback onPressed;
  final Function() onDoubleTap;
  bool outlinedBtn;
  final bool isLoading;
  void Function(TapDownDetails) pressedDown;
  CustomBtn(
      {this.textBtn,
      this.onPressed,
      this.outlinedBtn,
      this.isLoading,
      this.pressedDown,
      this.onDoubleTap});

  @override
  _CustomBtnState createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  bool downP = false;

  @override
  Widget build(BuildContext context) {
    bool outline = widget.outlinedBtn ?? false;
    return GestureDetector(
      onTap: widget.onPressed,
      onDoubleTap: widget.onDoubleTap,
      onTapDown: (TapDownDetails) {
        print("onTopDown");
        setState(() {
          outline ? Colors.white : Colors.green;
        });
      },
      onTapCancel: () {
        setState(() {
          outline ? Colors.green : Colors.white;
        });
      },
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
            color: outline ? Colors.green : Colors.white,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(
              12.0,
            )),
        margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
        child: Stack(
          children: [
            Visibility(
                visible: true,
                child: Center(
                    child: Text(
                  widget.textBtn,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: outline ? Colors.white : Colors.green,
                      fontWeight: FontWeight.w600),
                ))),
            Visibility(
              visible: widget.isLoading,
              child: Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClickText extends StatelessWidget {
  final String textClk;
  final VoidCallback tapTxt;
  ClickText({this.textClk, this.tapTxt});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: textClk,
        style: DefaultTextStyle.of(context).style,
        recognizer: TapGestureRecognizer()..onTap = tapTxt,
      ),
    );
  }
}

//round Button
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({
    Key key,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xff53B175),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(title, style: Constants.kTitleStyle),
      ),
    );
  }
}
