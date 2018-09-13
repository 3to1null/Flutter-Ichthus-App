import 'package:flutter/material.dart';

import 'get_schedule.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){getSchedule();},
    );
  }
}