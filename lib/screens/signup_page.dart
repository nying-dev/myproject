// ignore_for_file: unused_element, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/screens/login_page.dart';
import 'package:myproject/service/firestore.dart';
import 'package:myproject/widget/custom_button.dart';
import 'package:myproject/widget/custom_input.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  //Build an alert dialog to display some Errors

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text("Close Dialog"),
              )
            ],
          );
        });
  }

  //create use account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return '';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    String _createAccoutFeedBack = await _createAccount();
    setState(() {
      _registerdFormLoading = true;
    });
    if (_createAccoutFeedBack != '') {
      _alertDialogBuilder(_createAccoutFeedBack);
      //Set the regular
      setState(() {
        _registerdFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

//boolean loading
  bool _registerdFormLoading = false;
//Form Input field Values
  String _registerEmail = "";
  String _registerPassword = "";
  String _fname = "";
  String _lname = "";

//Focus Node for input Fields
  FocusNode _passwordFocusNode = FocusNode();
  @override
  void initState() {
    //TODO: implemnt initState
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 0.0, bottom: 20),
                child: Text(
                  "SIGN UP",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  //sample form
                  CustomInput(
                      hintText: "Email...",
                      isPasswordField: false,
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      focusNode: FocusNode(),
                      textInputAction: TextInputAction.next),
                  CustomInput(
                      hintText: "Password",
                      isPasswordField: true,
                      onChanged: (value) {
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                      textInputAction: TextInputAction.done),
                  CustomBtn(
                      textBtn: "Create account",
                      onPressed: () {
                        //Open The Dialog
                        _submitForm();
                        setState(() {
                          _registerdFormLoading = true;
                        });
                      },
                      isLoading: _registerdFormLoading,
                      outlinedBtn: true),
                  ClickText(
                    tapTxt: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    textClk: "Back to logIn",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
