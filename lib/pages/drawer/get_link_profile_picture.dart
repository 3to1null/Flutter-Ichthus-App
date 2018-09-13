import 'dart:async';
import 'dart:convert';

import '../../functions/request.dart';

void getLinkToProfilePicture(callBackToSetState) async {
  var response = await getDataFromAPI("/profile/picture/get", {'s':'s'});
  var jsonResponse = json.decode(response);
  final Map<String, dynamic> headers = jsonResponse["headers"]; 
  var url = jsonResponse["URL"]; 
  callBackToSetState(headers, url);
}