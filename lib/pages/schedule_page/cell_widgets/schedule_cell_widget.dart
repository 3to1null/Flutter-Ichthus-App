import 'package:flutter/material.dart';

import '../models/appointment.dart';
import '../schedule_widget_functions.dart';

const hourMultiplier = 1.45;
const offsetFromTop = 10.0;


class ScheduleCell extends StatelessWidget {
  final int index;
  final Appointment appointment;
  ScheduleCell(this.index, this.appointment);

  @override
  Widget build(BuildContext context) {

      String text1, text2, text3;
      try{text1 = appointment.teachers[0];}catch(e){text1 = "";}
      try{text2 = appointment.subjects[0];}catch(e){text2 = "";}
      try{text3 = appointment.locations[0];}catch(e){text3 = "";}

    return Positioned(
      left: 0.0,
      top: appointment.renderStart.toDouble() * hourMultiplier + offsetFromTop,
      right: 0.0,
      height: (appointment.renderEnd - appointment.renderStart).toDouble() * hourMultiplier,
      child: Container(
        margin: EdgeInsets.fromLTRB(3.0, 1.5, 3.0, 1.5),
        color: appointmentBackgroundColor(appointment, index),
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text3,
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text2,
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text1,
                )),
          ],
        ),
      ),
    );
  }
}