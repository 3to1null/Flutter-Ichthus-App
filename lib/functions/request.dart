import 'package:http/http.dart';
import 'dart:async';

import '../models/user_model.dart';

UserModel userModel = UserModel();

//const String baseURL= "https://api.fraignt.me/ichthus";
const String baseURL= "http://192.168.2.4:8000/ichthus";

String transformMapToString(Map data){
  String dataString = "?";
  data.forEach((k, v){
    k.toString();
    v.toString();
    dataString += '$k=$v&';
  });
  return dataString;
}

Map addDefaultEntries(Map data){
  data["__sessionID"] = userModel.sessionID;
  data["__key"] = userModel.sessionKey;
  data["__userCode"] = userModel.userCode;
  return data;
}

Future<String> getDataFromAPI(String path, Map data, {bool useSessionData: true}) async {
  String requestURL = baseURL + path;
  if(useSessionData){
    data = addDefaultEntries(data);
  }
  if(data != null){
    String dataString = transformMapToString(data);
    requestURL += dataString;
  }
  final response = await get(requestURL);
  return(response.body);
  //return response;
}

Future<String> postDataToAPI(String path, Map data, {bool useSessionData: true}) async {
  String requestURL = baseURL + path;
  if(useSessionData){
    data = addDefaultEntries(data);
  }
  final Response response = await post(requestURL, body: data);
  return response.body;
}

