import 'package:flutter/material.dart';

///Singleton that houses global information and shared variables.
class GlobalModel {
  static final GlobalModel _globalModel = new GlobalModel._internal();

  factory GlobalModel() {
    return _globalModel;
  }

  GlobalModel._internal();

  double screenHeight;
  double scheduleHourMultiplier;

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

}