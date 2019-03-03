import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'request.dart';

/// Gets the profileinfo of logged in user.
Future<Map> getProfileInfo() async {
  Duration timeout = Duration(days: 1);
  var returnData;

  // Recently got profile data.
  if(userModel.userProfileInfo != null && userModel.userProfileInfo.isNotEmpty
   && DateTime.now().difference(userModel.lastUpdatedProfileInfo).inHours < 4){
      return userModel.userProfileInfo;
  }

  // Got profile data, but not recent.
  if(userModel.userProfileInfo != null && userModel.userProfileInfo.isNotEmpty){
      timeout = Duration(seconds: 2);
  }

  try{
    var response = await getDataFromAPI("/profile/info/get", {}).timeout(timeout);
    returnData = json.decode(response);
    userModel.userProfileInfo = returnData;
    userModel.lastUpdatedProfileInfo = DateTime.now();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userModel", userModel.toJSONString());

  }catch(TimeoutException){
    returnData = userModel.userProfileInfo;
  }

  return returnData;
}