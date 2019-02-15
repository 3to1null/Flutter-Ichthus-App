import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../details_page/details_page.dart';
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

  void _openDetailsPage(context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        return DetailsPage(appointment);
      }
    ));
  }

  TextStyle _cellTextStyle(context){
    TextStyle baseStyle = Theme.of(context).textTheme.body1;
    if(appointment.cancelled){
      return baseStyle.copyWith(decoration: TextDecoration.lineThrough);
    }
    if(appointment.moved || appointment.isNew){
      return baseStyle.copyWith(fontStyle: FontStyle.italic);
    }
    return baseStyle;
  }

  @override
  Widget build(BuildContext context) {
    String textTeachers, textSubjects, textLocations;
    try{textTeachers = appointment.teachers.join(', ');}catch(e){textTeachers = "";}
    try{textSubjects = appointment.subjects.join(', ');}catch(e){textSubjects = "";}
    try{textLocations = appointment.locations.join(', ').toUpperCase();}catch(e){textLocations = "";}

    return Positioned(
      left: 0.0,
      top: appointment.renderStart.toDouble() * hourMultiplier + offsetFromTop,
      right: 0.0,
      height: (appointment.renderEnd - appointment.renderStart).toDouble() * hourMultiplier,
      child: InkWell(
        onTap: (){
          _openDetailsPage(context);
        },
        child: Ink(
          child: Hero(
            tag: appointment.uniqueId,
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
                    style: _cellTextStyle(context),
                    overflow: TextOverflow.clip,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}