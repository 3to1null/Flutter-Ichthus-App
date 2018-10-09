import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton(?) class that will have information about the user. It is populated as soon
/// as the app starts or when the user finishes logging in. It should always be available.
class UserModel {
  static final UserModel _userModel = new UserModel._internal();

  factory UserModel() {
    return _userModel;
  }

  UserModel._internal();

  String userCode;
  String userName;
  String userGroup;
  String sessionID;
  String sessionKey;
  bool isLoggedIn; 

  Map<String, dynamic> toMap(){
    return {
      "userCode": userCode,
      "userName": userName,
      "userGroup": userGroup,
      "sessionID": sessionID,
      "sessionKey": sessionKey,
      "isLoggedIn": isLoggedIn
    };
  }

  /// Returns a JSON-valid String which has all the data available in the model. Used to save the model to shared prefs.
  String toJSONString(){
    return json.encode(toMap());
  }

  /// Populates the model from sharedprefs. It takes an instance of SharedPreferences so the function is not async.
  populateFromStorage([SharedPreferences prefs]) {
    Map data = json.decode(prefs.getString("userModel"));
    userCode = data["userCode"];
    userName = data["userName"];
    userGroup = data["userGroup"];
    sessionID = data["sessionID"];
    sessionKey = data["sessionKey"];
    isLoggedIn = true;
  }

}