import 'package:flutter/material.dart';

import 'folder_file_list_card.dart';

import '../models/folder_model.dart';
import '../models/files_model.dart';

class FolderFileList extends StatelessWidget {

  final List foldersAndFiles;

  FolderFileList(this.foldersAndFiles);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        dynamic item = foldersAndFiles[index];
        if(item is Folder){
          return FolderListCard(folder: item);
        }else if(item is File){
          return FileListCard(file: item);
        }
        
      },
      childCount: foldersAndFiles.length),
    );
  }
}