import '../../../functions/request.dart';
import 'dart:convert';
import 'dart:async';

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
  List<Map> homeFolders;
  try{
    homeFolders = await getFilesAndFolders("/").timeout(const Duration(seconds: 5));
  }on TimeoutException catch(error){
    print(error);
    return await getHomeFolders();
  }

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
  String rawResponse;
  try{
    rawResponse = await getDataFromAPI("/files/list/recent", {});
  }on TimeoutException catch(error){
    print(error);
    return await getRecentFiles();
  }

  List response = json.decode(rawResponse);
  
  List<File> returnFileList = [];
  for(Map file in List<Map>.from(response)){
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