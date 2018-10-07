import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app_wrapper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new IchthusApp());
}

class IchthusApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ICV App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      //AppWrapper checks if a user is logged in and either starts app or shows the login.
      home: AppWrapper(
        analytics,
        observer,
      ),
    );
  }
}
