import 'package:flutter/material.dart';

import 'schedule_widget.dart';

class ScheduleTabWrapper extends StatefulWidget {
  final List scheduleData;

  ScheduleTabWrapper(this.scheduleData);
  @override
  _ScheduleTabWrapperState createState() => _ScheduleTabWrapperState();
}

class _ScheduleTabWrapperState extends State<ScheduleTabWrapper> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Schedule(widget.scheduleData[0]),
        Schedule(widget.scheduleData[1]),
        Schedule(widget.scheduleData[2]),
        Schedule(widget.scheduleData[3]),
        Schedule(widget.scheduleData[4]),
        Schedule(widget.scheduleData[5]),
        Schedule(widget.scheduleData[6]),
      ],
    );
  }
}
