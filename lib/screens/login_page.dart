import 'package:flutter/material.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/screens/signup_page.dart';
import 'package:myproject/widget/custom_button.dart';
import 'package:myproject/widget/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

//
class _LogInState extends State<LoginPage> {
  //pop dialog
  Future<void> _alertDialogBuilder(String error, String Note) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(Note),
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

  Future<String> _logInAccount() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  //forgoy password
  @override
  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      _alertDialogBuilder("Sent to your email!", "Note");
    } on FirebaseAuthException catch (e) {
      _alertDialogBuilder(e.message.toString(), "Error");
    } catch (e) {
      _alertDialogBuilder(e.toString(), "Error");
    }
  }

  //submit form
  void _submitForm() async {
    String _createAccoutFeedBack = await _logInAccount();
    setState(() {
      _registeredFormLoading = true;
    });
    if (_createAccoutFeedBack != '') {
      _alertDialogBuilder(_createAccoutFeedBack, "Error");
      //Set the regular
      setState(() {
        _registeredFormLoading = false;
      });
    }
  }

  //boolean loading
  bool _registeredFormLoading = false;
  //Form Input field Values
  String _email = "";
  String _password = "";

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
                padding: EdgeInsets.only(top: 21.0),
                child: Text(
                  "Login your account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                      hintText: "Email...",
                      isPasswordField: false,
                      onChanged: (value) {
                        _email = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      focusNode: FocusNode(),
                      textInputAction: TextInputAction.next),
                  CustomInput(
                      hintText: "password",
                      isPasswordField: true,
                      onChanged: (value) {
                        _password = value;
                      },
                      focusNode: _passwordFocusNode,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                      textInputAction: TextInputAction.done),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      _resetPassword();
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  CustomBtn(
                      textBtn: "Log In",
                      onPressed: () {
                        //Open The Dialog
                        setState(() {
                          _submitForm();
                          _registeredFormLoading = true;
                        });
                      },
                      isLoading: _registeredFormLoading,
                      outlinedBtn: true),
                  ClickText(
                      tapTxt: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      textClk: "Create New Account"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
