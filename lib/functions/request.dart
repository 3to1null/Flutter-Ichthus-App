import 'package:http/http.dart';
import 'dart:async';

import '../models/user_model.dart';

UserModel userModel = UserModel();

//const String baseURL= "https://api.fraignt.me/ichthus";
const String baseURL= "http://192.168.2.7:8000/ichthus";

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

/// Sends a GET request to the API on the location of [path] with [data].
Future<String> getDataFromAPI(String path, Map data, {bool useSessionData: true, bool noPanicOnError: true}) async {
  String requestURL = baseURL + path;
  if(useSessionData){
    data = addDefaultEntries(data);
  }
  if(data != null){
    String dataString = transformMapToString(data);
    requestURL += dataString;
  }
  try{
    final Response response = await get(requestURL);
    return(response.body);
  }catch(e){
    if(!noPanicOnError){
      throw(e);
    }
  }
  return "";
}

/// Sends a POST request to the API on the location of [path] with [data].
Future<String> postDataToAPI(String path, Map<String, String> data, {bool useSessionData: true, bool noPanicOnError: true}) async {
  String requestURL = baseURL + path;
  if(useSessionData){
    data = addDefaultEntries(data);
  }
  try{
    final Response response = await post(requestURL, body: data);
    return(response.body);
  }catch(e){
    if(!noPanicOnError){
      throw(e);
    }
  }
  return "";
}

