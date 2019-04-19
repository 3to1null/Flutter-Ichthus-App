import 'package:flutter/material.dart';

class FolderFileGrid extends StatelessWidget {

  final List foldersAndFiles;

  FolderFileGrid(this.foldersAndFiles);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        return Card(
          child: Column(
            children: <Widget>[
              Icon(Icons.folder),
              Text(foldersAndFiles[index].name)
            ],
          ),
        );
      },
      childCount: 2),
    );
  }
}