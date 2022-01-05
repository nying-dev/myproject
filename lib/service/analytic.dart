import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:myproject/models/model.dart';
import 'dart:core';

class AnalyticServices {
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> sendAnalyticsEvent(List<MCartItem> mcaritem) async {
    var items = [];
    for (var i in mcaritem) {
      items.add({
        'item_id': i.id,
        'item_name': i.item.name,
        'item_brand': 'I_B',
        'item_category': i.item.description,
        'item_variant': 'I_V',
        'quantity': '1',
        'price': i.item.price,
      });
    }
    print(items);
    await analytics.logEvent(
      name: 'purchase',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
        'items': items
      },
    );
  }

  Future<void> testSetCurrentScreen({String screenName}) async {
    await analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: 'AnalyticsDemo',
    );
  }
}
