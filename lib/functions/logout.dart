import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

/// Removes all stored values and stops the app, logging the user out.
void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    SystemNavigator.pop();
}