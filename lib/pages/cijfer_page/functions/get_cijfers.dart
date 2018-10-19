import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../functions/request.dart';

import '../../../models/user_model.dart';

Future<bool> _hasThisCijferPeriodInCache(int period) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userMarks = prefs.getString("_userMarksPeriod$period");
  if (userMarks == null) {
    return false;
  }
  return true;
}

Stream<List<Map<String, dynamic>>> getCijfers(int period) async* {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (await _hasThisCijferPeriodInCache(period)) {
    String userMarks = prefs.getString("_userMarksPeriod$period");
    yield List<Map<String, dynamic>>.from(json.decode(userMarks));
  }
  String cijfersResponse =
      await postDataToAPI('/marks/get', {"periode": period.toString()});
  if (cijfersResponse != null) {
    yield List<Map<String, dynamic>>.from(json.decode(cijfersResponse));
    prefs.setString("_userMarksPeriod$period", cijfersResponse);
  }
}
