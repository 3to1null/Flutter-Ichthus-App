import 'dart:convert';
import 'dart:async';

import 'request.dart';
import '../models/global_model.dart';

GlobalModel globalModel = GlobalModel();

Future<Map> getProfileInfo() async {
  if(userModel.userProfileInfo != null && userModel.userProfileInfo.isNotEmpty
   && DateTime.now().difference(userModel.lastUpdatedProfileInfo).inHours < 4){
      return userModel.userProfileInfo;
  }
  var response = await getDataFromAPI("/profile/info/get", {});
  var jsonResponse = json.decode(response);
  userModel.userProfileInfo = jsonResponse;
  userModel.lastUpdatedProfileInfo = DateTime.now();
  return jsonResponse;
}