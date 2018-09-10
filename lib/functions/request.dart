import 'package:flutter/services.dart';
import 'package:http/http.dart';

const String baseURL= "http://127.0.0.1::8000/ichthus";

getDataFromAPI(String path, [Map data]) async {
  String requestURL = baseURL + path;
  final test = await get(requestURL);
  print(test);
}