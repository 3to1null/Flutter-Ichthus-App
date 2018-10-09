import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import '../../functions/get_week_number.dart';

import '../drawer/drawer.dart';
import 'schedule_widget_tab_wrapper.dart';
import '../../widgets/loading_animation.dart';
import 'search_widgets/schedule_search_delegate.dart';

import 'get_schedule.dart';

import '../../models/user_model.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final GlobalKey<ScaffoldState> _scheduleScaffoldKey =
      GlobalKey<ScaffoldState>();
  final ScheduleSearchDelegate _delegate = ScheduleSearchDelegate();
  UserModel userModel = UserModel();
  bool hasLoaded = false;
  int weekNumber = getWeekNumber();
  String titleName;
  Map currentUserData;
  List scheduleData;

  String setTitleName() {
    if (currentUserData == null) {
      return userModel.userName;
    } else {
      return currentUserData["name"];
    }
  }

  bool isDefaultUser() {
    try {
      if (currentUserData["userCode"] != userModel.userCode &&
          currentUserData["userCode"] != "~me") {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      return true;
    }
  }

  void getScheduleSetStateCallback(scheduleResponseData) {
    if (!hasLoaded) {
      setState(() {
        scheduleData = scheduleResponseData;
        hasLoaded = true;
      });
    }
  }

  void setNewSchedule(Map userData) {
    if (userData == null) {
      return;
    }
    setState(() {
      hasLoaded = false;
      currentUserData = userData;
      titleName = setTitleName();
    });
    getSchedule(
            userCode: userData['userCode'],
            callBack: getScheduleSetStateCallback)
        .catchError((e) {
      print(e);
      _scheduleScaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
            "Er is iets fout gegaan bij het laden van ${titleName.trim()}'s rooster. Je eigen rooster wordt nu weergegeven."),
      ));
      setNewSchedule(
          {"name": userModel.userName, "userCode": userModel.userCode});
    });
  }

  @override
  void initState() {
    getSchedule(callBack: getScheduleSetStateCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 7,
      initialIndex: 1,
      child: Scaffold(
        key: _scheduleScaffoldKey,
        drawer: CompleteDrawer(widget.fbAnalytics, widget.fbObserver),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: Text(titleName != null ? titleName : userModel.userName),
                //title: TextField(),
                forceElevated: true,
                pinned: true,
                snap: false,
                floating: true,
                leading: IconButton(
                  tooltip: 'Navigatie Menu',
                  icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_arrow,
                      color: Colors.white,
                      progress: _delegate.transitionAnimation),
                  onPressed: () {
                    _scheduleScaffoldKey.currentState.openDrawer();
                  },
                ),
                actions: <Widget>[
                  // TODO: icon to load default schedule
                  !isDefaultUser()
                      ? IconButton(
                          tooltip: 'Terug naar eigen rooster',
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            setNewSchedule({
                              "userCode": userModel.userCode,
                              "name": userModel.userName
                            });
                          },
                        )
                      : Container(),
                  IconButton(
                    tooltip: 'Zoeken',
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      final selected = await showSearch(
                        context: context,
                        delegate: _delegate,
                      );
                      setNewSchedule(selected);
                    },
                  )
                ],
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
            ];
          },
          body: (hasLoaded
              ? ScheduleTabWrapper(scheduleData)
              : LoadingAnimation()),
        ),
      ),
    );
  }
}
