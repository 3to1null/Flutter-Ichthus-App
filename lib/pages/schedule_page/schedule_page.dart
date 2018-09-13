import 'package:flutter/material.dart';

import '../../functions/request.dart';

import '../drawer/drawer.dart';
import 'schedule_widget.dart';

import '../../models/user_model.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.userName),
      ),
      drawer: CompleteDrawer(),
      body: Schedule(),
    );
  }
}