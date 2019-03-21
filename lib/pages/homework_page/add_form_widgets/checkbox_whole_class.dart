import 'package:flutter/material.dart';
import 'form_data.dart';

class CheckBoxWholeClassHomework extends StatefulWidget {
  @override
  _CheckBoxWholeClassHomeworkState createState() => _CheckBoxWholeClassHomeworkState();
}

class _CheckBoxWholeClassHomeworkState extends State<CheckBoxWholeClassHomework> {
  bool checked = formData['is_for_group'] == "true" ? true : false;
  
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: checked,
      title: Text("Huiswerk is voor de hele klas"),
      subtitle: Text("Zoja, dan wordt het huiswerk in de agenda van de hele klas geplaatst."),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (bool value){
        formData['is_for_group'] = value ? "true" : "false";
        setState(() {
         checked = formData['is_for_group'] == "true" ? true : false; 
        });
      },
    );
  }
}