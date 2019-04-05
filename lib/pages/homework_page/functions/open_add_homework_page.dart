import 'package:flutter/material.dart';  
import '../add_homework_page.dart';
  
/// Open the AddHomeWorkPage to the given [context], the form fields will be populated with data from [homeworkItem].
/// If a [headerText] is provided, the title will be set to it.   
void openAddHomeworkPage(BuildContext context, [Map homeworkItem, String headerText]){
  Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context){
      print(headerText);
      return AddHomeworkPage(homeworkItem, headerText);
    }
  ));
}