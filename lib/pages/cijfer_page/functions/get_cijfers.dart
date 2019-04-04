import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../functions/request.dart';

import '../models/cijfer_data_model.dart';

CijferDataModel _cijferDataModel = CijferDataModel();

bool _hasThisCijferPeriodInCache(int period, SharedPreferences prefs) {
  String userMarks = prefs.getString("_userMarksPeriod$period");
  if (userMarks == null) {
    return false;
  }
  return true;
}

Future<void> addCijfersFromServerToControllerAndCache(StreamController streamController, int period, {bool isFromRefresh: false, SharedPreferences prefs, bool hasCache: true}) async {

  if(prefs == null){
    prefs = await SharedPreferences.getInstance();
  }

  String cijfersResponse = await postDataToAPI('/marks/get', {"periode": period.toString(), "force": isFromRefresh ? "true" : "false"});

  if (cijfersResponse != null && cijfersResponse != "" && cijfersResponse != "[]" && cijfersResponse != "false") {
    _cijferDataModel.periodsLoadedThisRun.add(period);
    List<Map<String, dynamic>> decodedResponse = List<Map<String, dynamic>>.from(json.decode(cijfersResponse));
    if(!streamController.isClosed){streamController.add(decodedResponse);}
    _cijferDataModel.setCijfersForPeriodInRam(period, decodedResponse);
    prefs.setString("_userMarksPeriod$period", cijfersResponse);
  }else if(!isFromRefresh && !hasCache){
    if(!streamController.isClosed){streamController.add([{'data': false}]);}
  }
}

abstract class GetCijfers{

  StreamController<List<Map<String, dynamic>>> cijferStreamController;

  void getCijfers(int period) async {
    if(_cijferDataModel.periodsLoadedThisRun == null){
      _cijferDataModel.periodsLoadedThisRun = [0];
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool hasCache = _hasThisCijferPeriodInCache(period, prefs);

    if(_cijferDataModel.periodsLoadedThisRun.contains(period) && _cijferDataModel.getCijferForPeriodFromRam(period) != null){
      cijferStreamController.add(_cijferDataModel.getCijferForPeriodFromRam(period));
    } else if (hasCache) {
      String userMarks = prefs.getString("_userMarksPeriod$period");
      if(!cijferStreamController.isClosed){cijferStreamController.add(List<Map<String, dynamic>>.from(json.decode(userMarks)));}
    }

    if (!_cijferDataModel.periodsLoadedThisRun.contains(period)) {
      addCijfersFromServerToControllerAndCache(cijferStreamController, period, prefs: prefs, hasCache: hasCache);
    }
  }
}

