import 'package:flutter/material.dart';  
import '../add_homework_page.dart';
  
void openAddHomeworkPage(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context){
      return AddHomeworkPage();
    }
  ));
}