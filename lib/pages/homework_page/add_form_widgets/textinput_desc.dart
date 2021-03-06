import 'package:flutter/material.dart';
import 'form_data.dart';

class DescTextInput extends StatelessWidget {
  final _homeworkDescController = TextEditingController(text: formData['homework'] != "" ? formData['homework'] : null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _homeworkDescController,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
        labelText: "Huiswerk",
        helperText: "Het huiswerk dat je voor dit vak hebt.",
        icon: Icon(Icons.description)
      ),
      onChanged: (value){
        if(value != null){
          formData['homework'] = value.toString();
        }
      },
    );
  }
}