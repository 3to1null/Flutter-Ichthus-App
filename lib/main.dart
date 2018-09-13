import 'package:flutter/material.dart';

import 'pages/login_page/login_page.dart';
import 'pages/schedule_page/schedule_page.dart';



void main() => runApp(new IchthusApp());

class IchthusApp extends StatelessWidget {

  final bool isLoggedIn = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ICV App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      home: isLoggedIn ? SchedulePage() : LoginPage(),
    );
  }
}

