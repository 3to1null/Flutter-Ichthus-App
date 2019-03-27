import 'package:flutter/material.dart';
import 'schedule_widget.dart';

class ScheduleTabWrapper extends StatefulWidget {
  final List scheduleData;
  final Function onRefreshCallback;
  final Map currentUserData;

  ScheduleTabWrapper(this.scheduleData, this.onRefreshCallback, this.currentUserData);
  @override
  _ScheduleTabWrapperState createState() => _ScheduleTabWrapperState();
}

class _ScheduleTabWrapperState extends State<ScheduleTabWrapper> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[0]), userData: widget.currentUserData),
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[1]), userData: widget.currentUserData),
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[2]), userData: widget.currentUserData),
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[3]), userData: widget.currentUserData),
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[4]), userData: widget.currentUserData),
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[5]), userData: widget.currentUserData),
        _ScheduleRefreshWrapper(widget.onRefreshCallback, child: Schedule(widget.scheduleData[6]), userData: widget.currentUserData),
      ],
    );
  }
}

class _ScheduleRefreshWrapper extends StatelessWidget {

  final Widget child;
  final Map userData;
  final Function onRefreshCallback;

  _ScheduleRefreshWrapper(this.onRefreshCallback, {this.child, this.userData});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        onRefreshCallback(userData ?? {'userCode': "~me"}, forceRefresh: true);
      },
    );
  }
}
