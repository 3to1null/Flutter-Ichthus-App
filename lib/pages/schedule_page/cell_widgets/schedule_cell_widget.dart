import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../../../models/global_model.dart';
import '../models/appointment.dart';
import '../schedule_widget_functions.dart';

GlobalModel globalModel = GlobalModel();

double hourMultiplier = globalModel.scheduleHourMultiplier;
const offsetFromTop = 10.0;


class ScheduleCell extends StatelessWidget {
  final int index;
  final Appointment appointment;
  ScheduleCell(this.index, this.appointment);

  @override
  Widget build(BuildContext context) {

      String textTeachers, textSubjects, textLocations;
      try{textTeachers = appointment.teachers[0];}catch(e){textTeachers = "";}
      try{textSubjects = appointment.subjects[0];}catch(e){textSubjects = "";}
      try{textLocations = appointment.locations[0];}catch(e){textLocations = "";}

    return Positioned(
      left: 0.0,
      top: appointment.renderStart.toDouble() * hourMultiplier + offsetFromTop,
      right: 0.0,
      height: (appointment.renderEnd - appointment.renderStart).toDouble() * hourMultiplier,
      child: Container(
        decoration: BoxDecoration(
          color: appointmentBackgroundColor(appointment, index),
          borderRadius: BorderRadius.all(Radius.circular(2.0))
        ),
        margin: EdgeInsets.fromLTRB(3.0, 1.5, 3.0, 1.5),
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
        child: ClipRect(
            child: AutoSizeText(
              "$textLocations\n$textSubjects\n$textTeachers",
              overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}