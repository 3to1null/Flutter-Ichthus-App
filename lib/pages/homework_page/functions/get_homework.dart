import '../../../functions/request.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

List loadedHomework;
bool hasHomeworkInRam = false;
DateTime homeworkLoadedToRam;

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

  if(!hasHomeworkInRam || (DateTime.now().difference(homeworkLoadedToRam) > Duration(minutes: 3))){

    bool error = false;
    List homeworkList;
    String rawHomework = await getDataFromAPI('/homework/get', {});
    try{
        homeworkList = json.decode(rawHomework);
    }catch(e){
      print(e);
      error = true;
    }

    if(!error){
      hasHomeworkInRam = true;
      homeworkLoadedToRam = DateTime.now();
      loadedHomework = homeworkList;
      prefs.setString("_homeworkList", json.encode(homeworkList));
      yield homeworkList;
    }

  }


}