import '../../../functions/request.dart';
import 'dart:convert';

import '../models/files_page_model.dart';
import '../models/folder_model.dart';

Future<List<Map>> getFilesAndFolders(String path) async {
  FilesPageModel filesPageModel = FilesPageModel();

  Map response = json.decode(await getDataFromAPI("/files/list", {"path": path}));

  filesPageModel.cookies = Map<String, String>.from(response["cookies"]);

  List<Map> filesAndFolders = List<Map>.from(response["files"]);
  print(filesAndFolders);
  return filesAndFolders;
}

Future<List> getHomeFolders() async {
  List<Map> homeFolders = await getFilesAndFolders("/");
  List<Folder> returnFolderList = [];
  for(Map folder in homeFolders){
    if(folder["dir"] == true){
      returnFolderList.add(
        Folder(
          name: folder["name"],
          path: folder["path"],
          pathTo: folder["pathTo"],
          size: folder["size"] != "None" ? int.parse(folder["size"]) : null,
        )
      );
    }
  }
  return returnFolderList;
}