import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppAnlytic extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget Build(BuildContext context) {
    return AnalyticPage(
      analytics: analytics,
      observer: observer,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class AnalyticPage extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  AnalyticPage({this.analytics, this.observer});
  @override
  _AnalyticPageState createState() => _AnalyticPageState();
}

// ignore: camel_case_types
class _AnalyticPageState extends State<AnalyticPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<Null> _sendAnalytics(
      {String name, Map<String, Object> parameter}) async {
    await widget.analytics
        .logEvent(name: 'Home page', parameters: <String, dynamic>{});
  }
}
