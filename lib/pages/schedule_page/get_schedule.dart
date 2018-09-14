import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions/request.dart';

import '../../models/user_model.dart';

Future<bool> _hasOfflineSchedule(String userCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String lastLoadedSchedule = prefs.getString("_userScheduleTime$userCode");
  if(lastLoadedSchedule == null){
    return false;
  }
  String testIfSchedule = prefs.getString("_userSchedule$userCode");
  if(testIfSchedule == null){
    return false;
  }
  return true;
}

Future<Duration> _getTimeoutTime(String userCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String lastLoadedSchedule = prefs.getString("_userScheduleTime$userCode");
  DateTime lastLoadedScheduleTime = DateTime.parse(lastLoadedSchedule);
  DateTime timeNow = DateTime.now();
  Duration timeSinceLastLoaded = lastLoadedScheduleTime.difference(timeNow);
  if(timeSinceLastLoaded.inMinutes < 15){
    //if lower than 1 second, schedule is not called.
    return Duration(microseconds: 1);
  }else if(timeSinceLastLoaded.inHours < 4){
    return Duration(milliseconds: 1500);
  }else if(timeSinceLastLoaded.inHours < 16){
    return Duration(milliseconds: 2500);
  }else{
    return Duration(seconds: 6);
  }
}

void _storeSchedule(String userCode, List schedule) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("_userScheduleTime$userCode", DateTime.now().toString());
  prefs.setString("_userSchedule$userCode", json.encode(schedule));
}

Future<List> getSchedule({String userCode: "~me", callBack}) async {
  if(userCode == "~me"){
    userCode = UserModel().userCode;
  }
  String response;
  if(await _hasOfflineSchedule(userCode)){
    final Duration timeoutTime = await _getTimeoutTime(userCode);
    if(timeoutTime.inSeconds >= 1){
      response = await getDataFromAPI("/schedule/get", {"userCode": userCode}).timeout(timeoutTime);
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      response = prefs.getString("_userSchedule$userCode");
    }
  }else{
    response = await getDataFromAPI("/schedule/get", {"userCode": userCode});
  }
  final List jsonResponse = json.decode(response);
  _storeSchedule(userCode, jsonResponse);
  if(callBack != null){
    callBack(jsonResponse);
  }
  return jsonResponse;
}