import '../../../functions/request.dart';
import 'dart:convert';

import '../models/files_page_model.dart';
import '../models/folder_model.dart';
import '../models/files_model.dart';

Future<List<Map>> getFilesAndFolders(String path) async {
  FilesPageModel filesPageModel = FilesPageModel();

  Map response = json.decode(await getDataFromAPI("/files/list", {"path": path}));

  filesPageModel.cookies = Map<String, String>.from(response["cookies"]);
  filesPageModel.authToken = response["auth"].toString().substring(2, response["auth"].toString().length - 1);

  List<Map> filesAndFolders = List<Map>.from(response["files"]);
  return filesAndFolders;
}

Future<List> getHomeFolders() async {
  List<Map> homeFolders = await getFilesAndFolders("/");
  List<Folder> returnFolderList = [];
  for(Map folder in homeFolders){
    if(folder['dir'] == true){
      returnFolderList.add(Folder(
          name: folder["name"],
          path: folder["path"],
          pathTo: folder["pathTo"],
          size: folder["size"].runtimeType == int ? folder["size"] : 0
        ));
    }
  }
  return returnFolderList;
}

Future<List> getRecentFiles() async {
  List response = json.decode(await getDataFromAPI("/files/list/recent", {}));
  List<File> returnFileList = [];
  for(Map file in List<Map>.from(response)){
    print(file);
    returnFileList.add(File(
      name: file["name"],
      path: file["path"],
      pathTo: file["pathTo"],
      isImage: file["img"],
      type: file["type"],
      size: file["size"],
      fileId: file['fileId'],
      lastModified: file['last_modified']
    ));
  }
  return returnFileList;
}