import '../../../functions/request.dart';
import 'dart:convert';

import '../models/files_page_model.dart';

Future<List<Map>> getFilesAndFolders(String path) async {
  FilesPageModel filesPageModel = FilesPageModel();

  Map response = json.decode(await getDataFromAPI("/files/list", {"path": path}));

  filesPageModel.cookies = Map<String, String>.from(response["cookies"]);
  print(filesPageModel.cookies);

  List<Map> filesAndFolders = List<Map>.from(response["files"]);
  return filesAndFolders;
}