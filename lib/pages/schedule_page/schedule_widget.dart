import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../../models/global_model.dart';
import 'models/appointment.dart';

import 'cell_widgets/schedule_cell_widget.dart';

GlobalModel globalModel = GlobalModel();

const offsetFromTop = 10.0;
const hourAmount = 12;
double hourMultiplier = globalModel.scheduleHourMultiplier;
const headerHeight = 28.0;
double hourHeight = 60.0 * hourMultiplier;

class Schedule extends StatefulWidget {
  final List scheduleData;
  final int weekIndex;

  Schedule(this.scheduleData, this.weekIndex);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule>{
  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: WeekViewHeaderDelegate(widget.weekIndex),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: _buildGrid(),
        )
      ],
    );
  }

  Widget _buildGrid(){
    List<Widget> gridColumns = List.generate(6, (d) => _buildColumns(d));
    return SizedBox(
      height: hourHeight * hourAmount,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: gridColumns,
      ),
    );
  }

  Widget _buildColumns(int d){
    if(d == 0){return _buildHourColumn();}
    return _buildColumn(d - 1);
  }

  Widget _buildColumn(int dayIndex) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: _generateCells(dayIndex),
      ),
    );
  }

  Widget _buildHourColumn(){
    List<Widget> _buildHourCells(){
      List<Widget> returnList = new List();
      for(int i = 0; i < hourAmount; i++){
        final String hourText = (i + 8).toString() + ":00"; 
        returnList.add(Positioned(
          left: 0.0,
          top: 60 * hourMultiplier * i - 7 + offsetFromTop,
          right: 0.0,
          height: 60 * hourMultiplier,
          child: AutoSizeText(hourText, textAlign: TextAlign.center, maxLines: 1)
        ));
        returnList.add(Positioned(
          width: 2.3,
          top: 60 * hourMultiplier * i + offsetFromTop,
          right: 0.0,
          height: 1,
          child: Divider(color: Colors.black38),
        ));
      }
      return returnList;
    }

    return Expanded(
      flex: 1,
      child: Stack(
        children: _buildHourCells(),
      ),
    );
  }

  List<Widget> _generateCells(int dayIndex){
    List<Widget> returnList = new List();
    returnList.add(Positioned(
      left: 0.0,
      width: 1.0,
      top: 0.0,
      bottom: 0.0,
      child: VerticalDivider(color: Colors.black38),
    ));
    for(int i = 0; i < hourAmount; i++){
      returnList.add(Positioned(
          left: 0.0,
          top: 60 * hourMultiplier * i + offsetFromTop,
          right: 0.0,
          height: 1,
          child: Divider(color: Colors.black38),
        ));
    }
    int index = 0;
    for(final appointmentData in widget.scheduleData[dayIndex]){
      index += 1;
      returnList.add(
        ScheduleCell(index, Appointment.fromJson(appointmentData))
      );
    }
    return returnList;
  }

}


class WeekViewHeaderDelegate extends SliverPersistentHeaderDelegate {

  final int weekIndex;
  WeekViewHeaderDelegate(this.weekIndex);

  DateTime getWeek(weekIndex){
    DateTime thisWeek = DateTime.now();
    if(thisWeek.weekday == DateTime.sunday){
      thisWeek = thisWeek.add(Duration(days: 1));
    }
    thisWeek = thisWeek.add(Duration(days: 6 - thisWeek.weekday));
    return thisWeek.add(Duration(days: 7 * (weekIndex - 1)));
  }
  
  String getDayDate(DateTime week, String day){
    DateTime returnDay;
    switch (day) {
      case "mon":
        returnDay = week.subtract(Duration(days: week.weekday - 1));
        break;
      case "tue":
        returnDay = week.subtract(Duration(days: week.weekday - 2));
        break;
      case "wed":
        returnDay = week.subtract(Duration(days: week.weekday - 3));
        break;
      case "thu":
        returnDay = week.subtract(Duration(days: week.weekday - 4));
        break;
      case "fri":
        returnDay = week.subtract(Duration(days: week.weekday - 5));
        break;
      default:
    }
    return DateFormat("d/M/y").format(returnDay);
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    DateTime thisWeek = getWeek(weekIndex);

    List<String> weekHeaderTexts =  [
      'Maandag \n' + getDayDate(thisWeek, 'mon'),
      'Dinsdag \n' + getDayDate(thisWeek, 'tue'),
      'Woensdag \n' + getDayDate(thisWeek, 'wed'),
      'Donderdag \n' + getDayDate(thisWeek, 'thu'),
      'Vrijdag \n' + getDayDate(thisWeek, 'fri'),
    ];

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText(weekHeaderTexts[0], style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText(weekHeaderTexts[1], style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText(weekHeaderTexts[2], style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText(weekHeaderTexts[3], style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText(weekHeaderTexts[4], style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
        ],
      ),
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}



