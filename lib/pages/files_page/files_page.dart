import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import '../drawer/drawer.dart';
import '../../widgets/loading_animation.dart';

import 'functions/get_files.dart';
import 'widgets/folder_file_grid.dart';

class FilesPage extends StatefulWidget {
  FilesPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  Future<List> _getRootFilesFuture;

  @override
  void initState() {
    super.initState();
    _getRootFilesFuture = getHomeFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompleteDrawer(widget.fbAnalytics, widget.fbObserver),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Bestanden"),
            ),
          ),
          FutureBuilder(
            future: _getRootFilesFuture,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done: return FolderFileGrid(snapshot.data); 
                default: return SliverToBoxAdapter(child: LoadingAnimation());
              }
            },
          )
        ],
      ),
    );
  }
}
