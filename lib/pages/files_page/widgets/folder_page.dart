import 'package:flutter/material.dart';

import '../../drawer/drawer.dart';
import '../../../widgets/loading_animation.dart';

import '../functions/handle_new_item.dart';
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

  Stream<List<Folder>> _childFolderStream;
  Stream<List<File>> _childFilesStream;

  @override
  void initState() {
    _childFolderStream = widget.folder.childFoldersStream;
    _childFilesStream = widget.folder.filesStream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompleteDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32),
        foregroundColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Colors.white,
        onPressed: (){handleNewItem(context, widget.folder);},
      ),
      body: Hero(
        tag: widget.heroTag + "ads",
        child: CustomScrollView(
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
            ValueListenableBuilder(
              valueListenable: widget.folder.isLoading,
              builder: (BuildContext context, double isLoading, Widget child){
                return SliverToBoxAdapter(
                  child: AnimatedCrossFade(
                    firstChild: Container(), 
                    secondChild: LinearProgressIndicator(
                      value: isLoading == 1.0 ? null : isLoading,
                    ),
                    duration: Duration(milliseconds: 100), 
                    crossFadeState: isLoading == null ? CrossFadeState.showFirst : CrossFadeState.showSecond
                  ),
                );
              },
            ),
            StreamBuilder(
              initialData: widget.folder.hasCachedFilesAndFolders ? widget.folder.cachedChildFolders : null,
              stream: _childFolderStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                print(snapshot);
                switch(snapshot.connectionState){
                  case ConnectionState.active: return SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    sliver: FolderFileList(snapshot.data),
                  ); 
                  case ConnectionState.done: return SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    sliver: FolderFileList(snapshot.data),
                  ); 
                  default: return snapshot.data == null ? 
                    SliverToBoxAdapter() : 
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      sliver: FolderFileList(snapshot.data),
                    );
                }
              },
            ),
            StreamBuilder(
              initialData: widget.folder.hasCachedFilesAndFolders ? widget.folder.cachedFiles : null,
              stream: _childFilesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.active: return SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    sliver: FolderFileList(snapshot.data),
                  ); 
                  case ConnectionState.done: return SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    sliver: FolderFileList(snapshot.data),
                  ); 
                  default: return snapshot.data == null ? 
                    SliverToBoxAdapter() : 
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      sliver: FolderFileList(snapshot.data),
                    );;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}