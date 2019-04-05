import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'form_data.dart';


class HomeworkDateInput extends StatefulWidget {
  @override
  _HomeworkDateInputState createState() => _HomeworkDateInputState();
}

class _HomeworkDateInputState extends State<HomeworkDateInput> {
  final _homeworkHourController = TextEditingController(text: formData['hour'] != "" ? formData['hour'] : null);
  bool hasChanged = false;

  @override
  Widget build(BuildContext context) {
    DateTime getInitialDate(){
      if(formData['date'] != "" && formData['date'] != null && formData['date'].length > 6){
        return DateFormat("yyyy-MM-dd").parseLoose(formData['date']);
      }
      return null;
    }
    DateTime initialDate = getInitialDate();
    return Row(
      children: <Widget>[
        Expanded(
          flex: 14,
          child: DateTimePickerFormField(
            format: DateFormat("EEEE',' d MMMM yyyy"),
            initialDate: initialDate,
            // Setting initialValue causes a bug where the year is ALWAYS reset to 1970
            // initialValue: initialDate,
            inputType: InputType.date,
            editable: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(2.0),
              // labelText: 'Datum',
              // Work around initialValuebug
              labelText: initialDate != null && !hasChanged ? DateFormat("EEEE',' d MMMM yyyy").format(initialDate) : "Datum",
              icon: Icon(Icons.date_range)
            ),
            onChanged: (DateTime value){
              if(value != null && value.isAfter(DateTime.now().subtract(Duration(days: 3)))){
                formData["date"] = DateFormat("yyyy-MM-dd").format(value);
                setState(() {
                  hasChanged = true; 
                });
              }else{
                formData["date"] = "";
                setState(() { });
              }
            },
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 4,
          child: TextField(
            controller: _homeworkHourController,
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