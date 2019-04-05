import 'package:flutter/material.dart';

import 'form_data.dart';

class VakTextInput extends StatelessWidget {
  final _homeworkSubjectController = TextEditingController(text: formData['subject'] != "" ? formData['subject'] : null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _homeworkSubjectController,
      textCapitalization: TextCapitalization.words,
      autofocus: !(formData['subject'] != "" && formData['subject'] != null),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(2.0),
        labelText: "Vak",
        icon: Icon(Icons.subject)
      ),
      onChanged: (value){
        if(value != null){
          formData['subject'] = value.toString();
        }
      }
    );
  }
}