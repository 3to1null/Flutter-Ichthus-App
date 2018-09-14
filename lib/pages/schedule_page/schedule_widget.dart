import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../functions/hex_to_color.dart';

class Schedule extends StatefulWidget {
  final List scheduleData;

  Schedule(this.scheduleData);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var appointment;
  final double cellHeight = 55.0;
  final List<String> dayNames = [
    "Maandag",
    "Dinsdag",
    "Woensdag",
    "Donderdag",
    "Vrijdag"
  ];

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
      return rowIsOdd ? hexToColor("b3b3b3") : hexToColor("cccccc");
    } else {
      if (appointment['cancelled']) {
        return rowIsOdd ? hexToColor("ff0000") : hexToColor("ff3333");
      } else if (appointment['moved']) {
        return rowIsOdd ? hexToColor("ff9900") : hexToColor("ffad33");
      } else if (appointment['type'] == "exam") {
        return rowIsOdd ? hexToColor("DCE775") : hexToColor("CDDC39");
      } else {
        return rowIsOdd ? hexToColor("ccccff") : hexToColor("e6e6ff");
      }
    }
  }

  int getRealIndex(fakeIndex) {
    if (fakeIndex <= 6) {
      return fakeIndex - 1;
    } else if (fakeIndex <= 12) {
      return fakeIndex - 2;
    } else if (fakeIndex <= 18) {
      return fakeIndex - 3;
    } else if (fakeIndex <= 24) {
      return fakeIndex - 4;
    } else if (fakeIndex <= 30) {
      return fakeIndex - 5;
    } else if (fakeIndex <= 36) {
      return fakeIndex - 6;
    } else if (fakeIndex <= 42) {
      return fakeIndex - 7;
    } else if (fakeIndex <= 48) {
      return fakeIndex - 8;
    } else if (fakeIndex <= 54) {
      return fakeIndex - 9;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 31,
      padding: EdgeInsets.all(0.0),
      itemCount: widget.scheduleData.length + 9 + 6,
      itemBuilder: (BuildContext context, int index) {
        if (index < 6) {
          return Container(
              color: Theme.of(context).primaryColorDark,
              child: index > 0
                  ? Center(
                      child: Text(
                      dayNames[index - 1],
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.white70),
                    ))
                  : Container());
        }
        index -= 6;
        if ((index) % 6 == 0) {
          bool rowIsOdd = ((index / 6) % 2 == 1);
          return Container(
            //color: rowIsOdd ? Colors.blue[200] : Colors.blue[300],
            color: rowIsOdd
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColorDark,
            child: Center(
              child: Text((index ~/ 6 + 1).toString(),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white70)),
            ),
          );
        } else {
          index = getRealIndex(index);
          appointment = widget.scheduleData[index];
          return Container(
            color: appointmentBackgroundColor(appointment, index),
          );
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
