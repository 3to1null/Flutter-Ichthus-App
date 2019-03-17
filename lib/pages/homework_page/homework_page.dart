import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import '../drawer/drawer.dart';
import '../../widgets/loading_animation.dart';

import 'homework_list.dart';

import 'get_homework.dart';

class NoHomeworkMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Geen huiswerk gevonden op leerlingweb.\n\nHeb je wel huiswerk op leerlingweb, maar zie je het niet in deze app? Geef het dan aan op de feedback pagina!',
      ),
    );
  }
}

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
            case ConnectionState.active: return snapshot.data.isNotEmpty ? HomeworkList(snapshot.data) : NoHomeworkMessage();
            case ConnectionState.done: return snapshot.data.isNotEmpty ? HomeworkList(snapshot.data) : NoHomeworkMessage();
          }
        },
      )
    );
  }
}