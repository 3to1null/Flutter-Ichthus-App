import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'models/user_model.dart';

import 'widgets/loading_animation.dart';

class AppWrapper extends StatelessWidget {
  AppWrapper(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  Widget build(BuildContext context) {
    Future<List> checkIfAlreadyLoggedIn() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool("isLoggedIn") != null &&
          prefs.getString("userModel") != null) {
        return [true, prefs];
      }
      return [false];
    }

    checkIfAlreadyLoggedIn().then((returnData) {
      if (returnData[0]) {
        UserModel userModel = UserModel();
        userModel.populateFromStorage(returnData[1]);
        Navigator.pushReplacementNamed(context, '/schedule');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    //Shouldn't be seen in theory, but lets make it fancy anyway.
    return LoadingAnimation();
  }
}
