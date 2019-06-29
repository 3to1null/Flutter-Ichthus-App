import 'dart:convert';

import '../models/folder_model.dart';
import '../../../functions/request.dart';


void createNewFolder(Folder parentFolder, String newFolderName) async {
  parentFolder.isLoading.value = true;
  String path = parentFolder.path.startsWith("__fraignt__api__") ? parentFolder.pathTo : parentFolder.path;
  await postDataToAPI('/files/mkdir', {'path': path, 'dirName': newFolderName});
  parentFolder.refresh();
}