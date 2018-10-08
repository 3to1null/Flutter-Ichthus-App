import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'app_wrapper.dart';
import 'pages/schedule_page/schedule_page.dart';
import 'pages/login_page/login_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => AppWrapper(analytics, observer),
        '/schedule': (context) => SchedulePage(analytics, observer),
        '/login': (context) => LoginPage(analytics, observer)
      },
      // home: AppWrapper(
      //   analytics,
      //   observer,
      // ),
    );
  }
}
