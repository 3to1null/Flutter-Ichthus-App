import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'form_data.dart';


class HomeworkDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 14,
          child: DateTimePickerFormField(
            format: DateFormat("EEEE',' d MMMM"),
            inputType: InputType.date,
            editable: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(2.0),
              labelText: 'Datum',
              icon: Icon(Icons.date_range)
            ),
            onChanged: (value){
              if(value != null){
                formData["date"] = DateFormat("yyyy-MM-dd").format(value);
              }
            },
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 4,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 10.0),
              labelText: 'Uur',
              icon: Icon(Icons.access_time)
            ),
            maxLength: 1,
            maxLengthEnforced: true,
            onChanged: (value){
              if(value != null){
                formData['hour'] = value.toString();
              }
            },
          ),
        )
      ],
    );
  }
}