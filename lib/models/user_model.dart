import 'dart:convert';

class UserModel {
  static final UserModel _userModel = new UserModel._internal();

  factory UserModel() {
    return _userModel;
  }

  UserModel._internal();

  String userCode;
  String userName;
  String userGroup;
  String password;
  String sessionID;
  String sessionKey;
  bool isLoggedIn; 

  Map<String, dynamic> toMap(){
    return {
      "userCode": userCode,
      "userName": userName,
      "userGroup": userGroup,
      "password": password,
      "sessionID": sessionID,
      "sessionKey": sessionKey,
      "isLoggedIn": isLoggedIn
    };
  }

  String toJSONString(){
    return json.encode(toMap());
  }

}