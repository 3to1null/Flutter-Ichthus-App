import 'package:http/http.dart';
import 'dart:async';

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

Future<String> getDataFromAPI(String path, [Map data]) async {
  String requestURL = baseURL + path;
  if(data != null){
    String dataString = transformMapToString(data);
    requestURL += dataString;
  }
  final response = await get(requestURL);
  return(response.body);
  //return response;
}

Future<String> postDataToAPI(String path, Map data) async {
  String requestURL = baseURL + path;
  final Response response = await post(requestURL, body: data);
  return response.body;
}

