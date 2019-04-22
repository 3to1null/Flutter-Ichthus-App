import 'package:flutter/material.dart';

import '../widgets/folder_page.dart';
import '../widgets/file_details_bottom_sheet.dart';

import '../models/folder_model.dart';
import '../models/files_model.dart';


void openFolderPage(BuildContext context, Folder folder, String heroTag){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        return FolderPage(folder, heroTag);
      }
    ));
}

void openFilePage(BuildContext context, File file){
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context){
      return FileSheet(file);
    }
  );
}