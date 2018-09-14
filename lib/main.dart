import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'app_wrapper.dart';

void main(){
  debugPaintSizeEnabled=false;
  runApp(new IchthusApp());
  }

class IchthusApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ICV App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      home: AppWrapper(),
    );
  }
}
