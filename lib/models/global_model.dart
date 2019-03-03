import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


///Singleton that houses global information and shared variables.
class GlobalModel {
  static final GlobalModel _globalModel = new GlobalModel._internal();

  factory GlobalModel() {
    return _globalModel;
  }

  GlobalModel._internal();

  double screenHeight;
  double scheduleHourMultiplier;

  List availableUserSchedulesOffline = [];

  ///Populates the model from the context
  populateFromContext(BuildContext context){
    double calculateScheduleHourMultiplier(double screenHeight){
    if(screenHeight < 500){return 1;}
    if(screenHeight < 600){return 1.15;}
    if(screenHeight < 600){return 1.25;}
    return 1.45;
    }
    screenHeight = MediaQuery.of(context).size.height;
    scheduleHourMultiplier = calculateScheduleHourMultiplier(screenHeight);
  }

  ///Populates the model from shared prefs
  populateFromStorage(SharedPreferences prefs){
    availableUserSchedulesOffline =  json.decode(prefs.getString('availableUserSchedulesOffline') ?? "[]");
  }

  ///Saves current state to storage
  saveToStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("availableUserSchedulesOffline", json.encode(availableUserSchedulesOffline));
  }

}