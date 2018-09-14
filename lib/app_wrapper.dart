import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user_model.dart';

import 'pages/schedule_page/schedule_page.dart';
import 'pages/login_page/login_page.dart';
import 'widgets/loading_animation.dart';


class AppWrapper extends StatelessWidget {
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SchedulePage()));
        UserModel userModel = UserModel();
        userModel.populateFromStorage(returnData[1]);
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });

    //Shouldn't be seen in theory, but lets make it fancy anyway.
    return LoadingAnimation();
  }
}
