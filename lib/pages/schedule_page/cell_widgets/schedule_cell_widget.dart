import 'package:flutter/material.dart';
import '../schedule_widget_functions.dart';

import '../details_page/details_page.dart';


import '../models/appointment.dart';

class ScheduleCell extends StatelessWidget {
  final int index;
  final Appointment appointment;
  ScheduleCell(this.index, this.appointment);

  void _openDetailsDialogPage(context, appointment){
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return DetailsPage(appointment);
      },
      fullscreenDialog: true
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (appointment.exists == false) {
      return Container(
        color: appointmentBackgroundColor(appointment, index),
      );
    } else {
      String text1, text2, text3;
      // try{text1 = appointment['teachers'][0].toString();}catch(e){text1 = "";}
      // try{text2 = appointment['subjects'][0].toString();}catch(e){text2 = "";}
      // try{text3 = appointment['locations'][0].toString();}catch(e){text3 = "";}
      try{text1 = appointment.teachers[0];}catch(e){text1 = "";}
      try{text2 = appointment.subjects[0];}catch(e){text2 = "";}
      try{text3 = appointment.locations[0];}catch(e){text3 = "";}

      return InkWell(
        onTap: (){
          //_openDetailsDialogPage(context, appointment);
          _openDetailsDialogPage(context, Map);
        },
        child: Ink(
          color: appointmentBackgroundColor(appointment, index),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text1,
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text2,
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text3,
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }
}
