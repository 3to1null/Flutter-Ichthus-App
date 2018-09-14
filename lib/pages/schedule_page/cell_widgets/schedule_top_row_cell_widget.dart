import 'package:flutter/material.dart';

class ScheduleTopRowCell extends StatelessWidget {
  final List<String> dayNames = [
    "Maandag",
    "Dinsdag",
    "Woensdag",
    "Donderdag",
    "Vrijdag"
  ];
  final int index;
  
  ScheduleTopRowCell(this.index);
  @override
  Widget build(BuildContext context) {
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
}
