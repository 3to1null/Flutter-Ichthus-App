import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../functions/request.dart';

import '../models/cijfer_data_model.dart';

CijferDataModel _cijferDataModel = CijferDataModel();

Future<bool> _hasThisCijferPeriodInCache(int period) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userMarks = prefs.getString("_userMarksPeriod$period");
  if (userMarks == null) {
    return false;
  }
  return true;
}

Stream<List<Map<String, dynamic>>> getCijfers(int period) async* {
  if(_cijferDataModel.periodsLoadedThisRun == null){
    _cijferDataModel.periodsLoadedThisRun = [0];
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (await _hasThisCijferPeriodInCache(period)) {
    String userMarks = prefs.getString("_userMarksPeriod$period");
    yield List<Map<String, dynamic>>.from(json.decode(userMarks));
  }
  if (!_cijferDataModel.periodsLoadedThisRun.contains(period)) {
    String cijfersResponse =
        await postDataToAPI('/marks/get', {"periode": period.toString()});
    if (cijfersResponse != null) {
      _cijferDataModel.periodsLoadedThisRun.add(period);
      yield List<Map<String, dynamic>>.from(json.decode(cijfersResponse));
      prefs.setString("_userMarksPeriod$period", cijfersResponse);
    }
  }
}
