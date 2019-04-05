import 'package:flutter/material.dart';  
import '../add_homework_page.dart';
  
/// Open the AddHomeWorkPage to the given [context], the form fields will be populated with data from [homeworkItem].
/// 
/// If a [headerText] is provided, the title will be set to it.   
/// 
/// If [pushReplace] is true, the current route will be disposed after the new route is finished animating in.
void openAddHomeworkPage(BuildContext context, [Map homeworkItem, String headerText, bool pushReplace=false]){
  if(pushReplace){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context){
        return AddHomeworkPage(homeworkItem, headerText);
      }
    ));
  }else{
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        return AddHomeworkPage(homeworkItem, headerText);
      }
    ));
  }

}