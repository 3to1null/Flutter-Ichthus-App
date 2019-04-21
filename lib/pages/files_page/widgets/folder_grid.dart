import 'package:flutter/material.dart';

import 'folder_grid_card.dart';

import '../models/folder_model.dart';
import '../models/files_model.dart';

class FolderGrid extends StatelessWidget {

  final List foldersAndFiles;
  final int crossAxisCount;

  FolderGrid(this.foldersAndFiles, {this.crossAxisCount: 2});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        dynamic item = foldersAndFiles[index];
        if(item is Folder){
          return FolderGridCard(folder: item);
        }
      },
      childCount: foldersAndFiles.length),
    );
  }
}