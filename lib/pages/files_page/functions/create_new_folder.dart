import 'dart:convert';

import '../models/folder_model.dart';
import '../../../functions/request.dart';


void createNewFolder(Folder folder, String newFolderName) async {
  String path = folder.path;
  json.decode(await postDataToAPI('/files/mkdir', {'path': path, 'dirName': newFolderName}));
}