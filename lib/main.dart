// new
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // new
import 'package:myproject/screens/landing_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() {
  // Modify from here
  runApp(MyApp());
  // to here.
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics _analytics = new FirebaseAnalytics();
  static FirebaseAnalyticsObserver _observer =
      new FirebaseAnalyticsObserver(analytics: _analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          // ignore: deprecated_member_use
          accentColor: Color(0xff20df35)),
      navigatorObservers: <NavigatorObserver>[_observer],
      home: LandingPage(),
    );
  }
}
