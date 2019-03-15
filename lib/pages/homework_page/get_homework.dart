import '../../functions/request.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List loadedHomework;
bool hasHomeworkInRam = false;

Stream<List> getHomework() async* {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  if(hasHomeworkInRam){
    yield loadedHomework;
  }else{
    String homeworkListStoredString = prefs.getString("_homeworkList");
    if (homeworkListStoredString != null){
      yield json.decode(homeworkListStoredString);
    }
  }

  List homeworkList = json.decode(await getDataFromAPI('/homework/get', {}));
  hasHomeworkInRam = true;
  loadedHomework = homeworkList;
  prefs.setString("_homeworkList", json.encode(homeworkList));
  print('yield new homeowkr');
  yield homeworkList;

}