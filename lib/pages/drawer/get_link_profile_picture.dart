import 'dart:convert';

import '../../functions/request.dart';
import '../../models/global_model.dart';

GlobalModel globalModel = GlobalModel();

void getLinkToProfilePicture(callBackToSetState) async {
  var response = await getDataFromAPI("/profile/all/get", {'s':'s'});
  var jsonResponse = json.decode(response);

  final Map<String, dynamic> headers = jsonResponse['picture']["headers"]; 
  var url = jsonResponse['picture']["URL"];
  
  userModel.userProfileInfo = jsonResponse['info'];
  userModel.lastUpdatedProfileInfo = DateTime.now();

  callBackToSetState(headers, url);
}