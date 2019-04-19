import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import '../drawer/drawer.dart';

import 'functions/get_files.dart';
import 'models/folder_model.dart';


class FilesPage extends StatefulWidget {
  FilesPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bestanden'),
          elevation: 0,
        ),
        drawer: CompleteDrawer(widget.fbAnalytics, widget.fbObserver),
        body: Container(
          child: MaterialButton(
            child: Text("test"),
            onPressed: () async {
              Folder test = Folder(name: "Bestanden", path: "/HomeDrive (H)/", pathTo: "/");
              print(await test.childFolders);
            },
          ),
        ));
  }
}
