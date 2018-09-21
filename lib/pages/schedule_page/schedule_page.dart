import 'package:flutter/material.dart';

import '../../functions/get_week_number.dart';

import '../drawer/drawer.dart';
import 'schedule_widget_tab_wrapper.dart';
import '../../widgets/loading_animation.dart';
import 'search_widgets/schedule_search_delegate.dart';

import 'get_schedule.dart';

import '../../models/user_model.dart';

class SchedulePage extends StatefulWidget {
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

  void getScheduleSetStateCallback(scheduleResponseData) {
    setState(() {
      scheduleData = scheduleResponseData;
      hasLoaded = true;
    });
  }

  void setNewSchedule(Map userData) {
    if(userData == null){return;}
    setState(() {
      hasLoaded = false;
      currentUserData = userData;
      titleName = setTitleName();
    });
    getSchedule(userCode: userData['userCode'], callBack: getScheduleSetStateCallback)
        .catchError((e) {
          print(e);
          _scheduleScaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                "Er is iets fout gegaan bij het laden van ${titleName.trim()}'s rooster. Je eigen rooster wordt nu weergegeven."
                ),
          ));
          setNewSchedule({
            "name": userModel.userName,
            "userCode": userModel.userCode
          });
        });
  }

  @override
  void initState() {
    getSchedule(callBack: getScheduleSetStateCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (!hasLoaded) {
    //   getSchedule(callBack: getScheduleSetStateCallback);
    // }

    return DefaultTabController(
      length: 7,
      initialIndex: 1,
      child: Scaffold(
        key: _scheduleScaffoldKey,
        drawer: CompleteDrawer(),
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
