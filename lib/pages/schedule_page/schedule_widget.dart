import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'schedule_widget_functions.dart';
import 'cell_widgets/schedule_top_row_cell_widget.dart';
import 'cell_widgets/schedule_side_column_cell_widget.dart';
import 'cell_widgets/schedule_cell_widget.dart';


import 'models/appointment.dart';

class Schedule extends StatefulWidget {
  final List scheduleData;

  Schedule(this.scheduleData);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var appointment;
  final double cellHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 31,
      padding: EdgeInsets.all(0.0),
      itemCount: widget.scheduleData.length + 9 + 6,
      itemBuilder: (BuildContext context, int index) {
        if (index < 6) {
          return ScheduleTopRowCell(index);
        } else {
          index -= 6;
          if ((index) % 6 == 0) {
            return ScheduleSideColumnCell(index);
          } else {
            index = getRealIndex(index);
            appointment = widget.scheduleData[index];
            if(appointment == false){
              appointment = {"exists": false};
            }
            return ScheduleCell(index, Appointment.fromJson(appointment));
          }
        }
      },
      staggeredTileBuilder: (int index) {
        if (index < 6) {
          final double dayCellHeight = 22.0;
          if (index == 0) {
            return StaggeredTile.extent(1, dayCellHeight);
          } else {
            return StaggeredTile.extent(6, dayCellHeight);
          }
        }
        index -= 6;
        if ((index) % 6 == 0) {
          return StaggeredTile.extent(1, cellHeight);
        }
        return StaggeredTile.extent(6, cellHeight);
      },
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
    );
  }
}
