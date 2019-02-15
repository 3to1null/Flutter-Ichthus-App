import 'dart:async';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'functions/report_error.dart';
import 'functions/is_in_debug_mode.dart';

import 'app_wrapper.dart';
import 'pages/schedule_page/schedule_page.dart';
import 'pages/cijfer_page/cijfer_page.dart';
import 'pages/login_page/login_page.dart';

void main() {
  timeDilation = 1.0;
  debugPaintSizeEnabled = false;
  runZoned<Future<Null>>(() async {
    runApp(new IchthusApp());
  }, onError: (error, stackTrace) {
    reportError(error, stackTrace);
  });
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
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
        '/cijfers': (context) => CijferPage(analytics, observer),
        '/login': (context) => LoginPage(analytics, observer)
      },
    );
  }
}
