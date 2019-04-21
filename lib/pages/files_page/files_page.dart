import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import '../drawer/drawer.dart';
import '../../widgets/loading_animation.dart';

import 'functions/get_files.dart';
import 'widgets/folder_grid.dart';
import 'widgets/folder_file_list.dart';

class FilesPage extends StatefulWidget {
  FilesPage(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

  @override
  _FilesPageState createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  Future<List> _getRootFilesFuture;
  Future<List> _getRecentFilesFuture;

  @override
  void initState() {
    super.initState();
    _getRootFilesFuture = getHomeFolders();
    _getRecentFilesFuture = getRecentFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompleteDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            forceElevated: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Bestanden"),
            ),
          ),
          FutureBuilder(
            future: _getRootFilesFuture,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done: return FolderGrid(snapshot.data); 
                default: return SliverToBoxAdapter(child: Padding(padding: EdgeInsets.only(top: 100.0), child: LoadingAnimation()));
              }
            },
          ),
          FutureBuilder(
            future: _getRecentFilesFuture,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done: return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 8.0, 16.0),
                    child: Text("Recente Bestanden", style: Theme.of(context).textTheme.title),
                  )
                ); 
                default: return SliverToBoxAdapter();
              }
            },
          ),
          FutureBuilder(
            future: _getRecentFilesFuture,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.done: return FolderFileList(snapshot.data); 
                default: return SliverToBoxAdapter();
              }
            },
          ),
          SliverToBoxAdapter(
            child: Container(height: 24.0),
          )
        ],
      ),
    );
  }
}
