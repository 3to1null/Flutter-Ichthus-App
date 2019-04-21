import 'package:flutter/material.dart';

import '../models/folder_model.dart';
import '../models/files_model.dart';

class FolderListCard extends StatelessWidget {

  final Folder folder;

  FolderListCard({this.folder});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: ListTile(
        leading: Icon(Icons.folder),
        title: Text(folder.name),
      ),
    );
  }
}

class FileListCard extends StatelessWidget {

  final File file;

  FileListCard({this.file});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: ListTile(
        leading: Icon(Icons.insert_drive_file),
        title: Text(file.name),
      ),
    );
  }
}

