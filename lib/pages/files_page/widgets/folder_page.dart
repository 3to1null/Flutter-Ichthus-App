import 'package:flutter/material.dart';

import '../../drawer/drawer.dart';
import '../../../widgets/loading_animation.dart';

import '../widgets/folder_file_list.dart';
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
              automaticallyImplyLeading: false,
              leading: BackButton(),
              expandedHeight: 100,
              pinned: true,
              forceElevated: true,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(horizontal: 72.0, vertical: 8.0),
                title: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(child: Text(widget.folder.name.split("(")[0] + " " * 20), scrollDirection: Axis.horizontal),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          (!widget.folder.path.startsWith("__fraignt__api__") ? widget.folder.path  : widget.folder.pathTo) + " " * 25, 
                          style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.normal)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _folderSubFoldersFuture,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.done: return SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    sliver: FolderFileList(snapshot.data),
                  ); 
                  default: return SliverToBoxAdapter(child: Padding(padding: EdgeInsets.only(top: 100.0), child: LoadingAnimation()));
                }
              },
            ),
            FutureBuilder(
              future: _folderSubFilesFuture,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.done: return SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    sliver: FolderFileList(snapshot.data),
                  ); 
                  default: return SliverToBoxAdapter();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}