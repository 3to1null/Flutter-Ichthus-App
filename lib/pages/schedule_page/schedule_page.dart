import 'package:flutter/material.dart';

import '../../functions/get_week_number.dart';

import '../drawer/drawer.dart';
import 'schedule_widget_tab_wrapper.dart';

import 'get_schedule.dart';

import '../../models/user_model.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  UserModel userModel = UserModel();
  bool hasLoaded = false;
  int weekNumber = getWeekNumber();
  List scheduleData;

  void getScheduleSetStateCallback(scheduleResponseData) {
    setState(() {
      scheduleData = scheduleResponseData;
      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoaded) {
      getSchedule(callBack: getScheduleSetStateCallback);
    }

    return DefaultTabController(
      length: 7,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(userModel.userName),
          bottom: TabBar(
            isScrollable: true,
            //labelColor: Theme.of(context).primaryColor,
            tabs: <Widget>[
              Tab(text: "Vorige Week"),
              Tab(text: "Deze Week"),
              Tab(text: "Volgende Week"),
              Tab(text: "Week ${weekNumber + 2}"),
              Tab(text: "Week ${weekNumber + 3}"),
              Tab(text: "Week ${weekNumber + 4}"),
              Tab(text: "Week ${weekNumber + 5}"),
            ],
          ),
        ),
        drawer: CompleteDrawer(),
        //body: hasLoaded ? Schedule(scheduleData) : Container(),
        body: hasLoaded ? ScheduleTabWrapper(scheduleData) : Container(),
      ),
    );
  }
}
