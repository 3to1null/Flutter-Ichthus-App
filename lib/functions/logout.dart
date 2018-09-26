import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    SystemNavigator.pop();
}