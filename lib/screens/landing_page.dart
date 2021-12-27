import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myproject/constants.dart';
import 'package:myproject/screens/home_page.dart';
import 'package:myproject/screens/login_page.dart'; // new
import 'package:myproject/screens/signUp/form_show.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //if snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
            child: Text("Error:${snapshot.error}"),
          ));
        }
        //if snapshot has connected
        if (snapshot.connectionState == ConnectionState.done) {
          //streamBuilder can check the lohgin state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (
              context,
              streamSnapshot,
            ) {
              //if snapshot has error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${streamSnapshot.error}"),
                  ),
                );
              }
              //connection state active - Do the user login check inside the
              //if statement
              if (streamSnapshot.connectionState == ConnectionState.active) {
                // Get the use
                User _user = streamSnapshot.data;

                print(_user);
                // ignore: unnecessary_null_comparison
                if (_user == null) {
                  return LoginPage();
                } else {
                  String uid = _user.uid;
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(uid)
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot> streamFirestore) {
                        if (streamFirestore.hasData) {
                          if (streamFirestore.data.exists) {
                            return Homepage();
                          } else {
                            return FormShow();
                          }
                        }
                        return Scaffold(
                          body: Center(
                            child: CircularProgressIndicator()),
                        );
                      });
                }
              }
              //connecting the aut state --loadinf
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
