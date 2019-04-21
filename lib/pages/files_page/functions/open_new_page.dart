import 'package:flutter/material.dart';

import '../widgets/folder_page.dart';

import '../models/folder_model.dart';
import '../models/files_model.dart';


void openFolderPage(BuildContext context, Folder folder){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        return FolderPage(folder);
      }
    ));
}

void openFilePage(File file){

}