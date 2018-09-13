import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

void storeLoginResponseData(Map loginData) async{
  UserModel userModel = UserModel();
  userModel.userCode = loginData['userCode'];
  userModel.userName = loginData['userName'];
  userModel.userGroup = loginData['userGroup'];
  userModel.sessionID = loginData['sessionID'];
  userModel.sessionKey = loginData['key'];
  userModel.isLoggedIn = true;
  //SharedPreferences prefs = await SharedPreferences.getInstance();
}