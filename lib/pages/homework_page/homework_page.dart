import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import '../drawer/drawer.dart';
import '../../widgets/loading_animation.dart';

import 'homework_list.dart';

import 'get_homework.dart';

class HomeWorkPage extends StatefulWidget {
  HomeWorkPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _HomeWorkPageState createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Huiswerk'),
        elevation: 0,
      ),
      drawer: CompleteDrawer(widget.fbAnalytics, widget.fbObserver),
      body: StreamBuilder(
        stream: getHomework(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none: return LoadingAnimation();
            case ConnectionState.waiting: return LoadingAnimation();
            case ConnectionState.active: return HomeworkList(snapshot.data);
            case ConnectionState.done: return HomeworkList(snapshot.data);
          }
        },
      )
    );
  }
}