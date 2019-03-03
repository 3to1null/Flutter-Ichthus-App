import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sentry/sentry.dart';

import '../drawer/drawer.dart';
import 'widgets/cijfer_list_widget_tab_wrapper.dart';

import '../../models/user_model.dart';

class CijferPage extends StatefulWidget {
  CijferPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _CijferPageState createState() => _CijferPageState();
}

class _CijferPageState extends State<CijferPage> {

  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    int userGroupNumber;
    try{
      print(userModel.userGroup);
      userGroupNumber = int.parse(userModel.userGroup.substring(1,2));
    }catch(e){
      print(e);
      userGroupNumber = 0;
    }
    return DefaultTabController(
      length: 4,
      initialIndex: userGroupNumber > 3 ? 3 : 0,
      child: Scaffold(
        drawer: CompleteDrawer(widget.fbAnalytics, widget.fbObserver),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Text("Cijfers"),
                forceElevated: true,
                pinned: true,
                snap: false,
                floating: true,
                bottom: TabBar(
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(text: "Periode 1"),
                    Tab(text: "Periode 2"),
                    Tab(text: "Periode 3"),
                    Tab(text: "Examendossier")
                  ],
                ),
              ),
            ];
          },
          body: CijferListTabWrapper()
        ),
      ),
    );
  }
}
