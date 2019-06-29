import 'package:flutter/material.dart';

import '../../../functions/random_string.dart';
import '../functions/open_new_page.dart';
import '../functions/file_icon_picker.dart';

import '../models/folder_model.dart';
import '../models/files_model.dart';

class FolderListCard extends StatelessWidget {

  final Folder folder;

  FolderListCard({this.folder});

  @override
  Widget build(BuildContext context) {

    String heroTag = this.folder.path + randomString(8);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: ListTile(
        leading: Icon(Icons.folder),
        title: Text(folder.name),
        onTap: (){openFolderPage(context, folder, heroTag);},
        onLongPress: (){openFolderDetailSheet(context, folder);},
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
        leading: fileIconPicker(file, false),
        title: Text(file.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: (){openFileDetailSheet(context, file);},
      ),
    );
  }
}

