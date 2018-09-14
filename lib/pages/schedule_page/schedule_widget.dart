import 'package:flutter/material.dart';

import '../../functions/hex_to_color.dart';

class Schedule extends StatefulWidget {
  final List scheduleData;

  Schedule(this.scheduleData);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var appointment;

  Color appointmentBackgroundColor(appointment, index) {
    bool rowIsOdd = false;
    if (index < 5 ||
        (index >= 10 && index < 15) ||
        (index >= 20 && index < 25) ||
        (index >= 30 && index < 35) ||
        (index >= 40 && index < 45)) {
          rowIsOdd = true;
        }
    if (appointment == false) {
      return rowIsOdd ? hexToColor("b3b3b3"): hexToColor("cccccc");
    }else{
      if(appointment['cancelled']){
        return rowIsOdd ? hexToColor("ff0000"): hexToColor("ff3333");
      }else if(appointment['moved']){
        return rowIsOdd ? hexToColor("ff9900"): hexToColor("ffad33");
      }else if(appointment['type'] == "exam"){
        return rowIsOdd ? hexToColor("DCE775"): hexToColor("CDDC39");
      }else{
        return rowIsOdd ? hexToColor("ccccff"): hexToColor("e6e6ff");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.scheduleData.length,
      itemBuilder: (BuildContext context, int index) {
        appointment = widget.scheduleData[index];
        return Container(
          color: appointmentBackgroundColor(appointment, index),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.2,
          crossAxisCount: 5),
    );
  }
}
