import 'package:flutter/material.dart';

import '../../drawer/drawer.dart';
import '../../../widgets/loading_animation.dart';


import '../models/folder_model.dart';
import '../models/files_model.dart';


class FolderPage extends StatefulWidget {
  FolderPage(this.folder, this.heroTag);

  final Folder folder;
  final String heroTag;

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {

  Future<List<Folder>> _folderSubFoldersFuture;
  Future<List<File>> _folderSubFilesFuture;

  @override
  void initState() {
    _folderSubFoldersFuture = widget.folder.childFolders;
    _folderSubFilesFuture = widget.folder.files;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: Scaffold(
        drawer: CompleteDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(widget.folder.name.split("(")[0]),
              automaticallyImplyLeading: false,
              leading: BackButton(),
              expandedHeight: 100,
              pinned: true,
              forceElevated: true,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(horizontal: 72.0, vertical: 14.0),
                title: Text(widget.folder.path, style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}