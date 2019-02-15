import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

void updateUserModel() async{
  UserModel userModel = UserModel();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userModel", userModel.toJSONString());
}