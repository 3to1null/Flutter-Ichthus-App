import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'models/appointment.dart';

import 'cell_widgets/schedule_cell_widget.dart';

const offsetFromTop = 10.0;
const hourAmount = 12;
const hourMultiplier = 1.45;
const headerHeight = 28.0;
const hourHeight = 60.0 * hourMultiplier;

class Schedule extends StatefulWidget {
  final List scheduleData;

  Schedule(this.scheduleData);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule>{
  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: WeekViewHeaderDelegate(),
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
          width: i <2 ? 5.0 : 1.5,
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
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Container()),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText('Maandag', style: TextStyle(color: Colors.black))),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText('Dinsdag', style: TextStyle(color: Colors.black))),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText('Woensdag', style: TextStyle(color: Colors.black))),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText('Donderdag', style: TextStyle(color: Colors.black))),
            decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12))),
          )),
          Expanded(flex: 2, child: Container(
            child: Center(child: AutoSizeText('Vrijdag', style: TextStyle(color: Colors.black))),
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



