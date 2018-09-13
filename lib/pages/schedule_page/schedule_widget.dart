import 'package:flutter/material.dart';



class Schedule extends StatefulWidget {
  final List scheduleData;

  Schedule(this.scheduleData);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {



  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.scheduleData.length,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        childAspectRatio: 1.2,
        crossAxisCount: 5
      ),
    );
  }
}
