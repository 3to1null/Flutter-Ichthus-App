import 'package:flutter/material.dart';

import '../widgets/new_item_bottom_sheet.dart';
import '../widgets/new_folder_dialog.dart';
import '../models/folder_model.dart';

void handleNewItem(BuildContext context, Folder folder){
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context){
      return NewItemSheet(folder, context);
    }
  );
}

void handleNewFolder(BuildContext pageContext, Folder folder){
  showDialog(
    context: pageContext,
    builder: (BuildContext context){
      return NewFolderDialog(pageContext, folder);
    }
  );
}