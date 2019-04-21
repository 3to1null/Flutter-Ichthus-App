import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import '../../drawer/drawer.dart';
import '../../../widgets/loading_animation.dart';


import '../models/folder_model.dart';
import '../models/files_model.dart';


class FolderPage extends StatefulWidget {
  FolderPage(this.folder);

  final Folder folder;

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
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
              title: Text(widget.folder.name),
            ),
          ),
        ],
      ),
    );
  }
}