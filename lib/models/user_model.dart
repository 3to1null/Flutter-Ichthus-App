import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  String toJSONString(){
    return json.encode(toMap());
  }

  populateFromStorage([SharedPreferences prefs]) {
    // if(prefs == null){
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    // }
    Map data = json.decode(prefs.getString("userModel"));
    userCode = data["userCode"];
    userName = data["userName"];
    userGroup = data["userGroup"];
    sessionID = data["sessionID"];
    sessionKey = data["sessionKey"];
    isLoggedIn = true;
  }

}