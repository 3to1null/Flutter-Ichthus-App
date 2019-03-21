import 'package:flutter/material.dart';

import 'form_data.dart';

class VakTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.words,
      autofocus: true,
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