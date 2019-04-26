import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/files_model.dart';
import '../models/files_page_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();
const String downloadDir = "/Download";

void handleFileDownload(File file) async {
  if(!await _getPermission()){
    print('no permission');
    return;
  }
  await _checkOrCreateDownloadDirectory();
  Directory externalDir = await getExternalStorageDirectory();
  final String taskId = await FlutterDownloader.enqueue(
    url: file.downloadURL,
    headers: {
          'Cookie': _filesPageModel.cookieString, 
          'connection': "close",
          'Authorization': "Basic " + _filesPageModel.authToken  
        },
    showNotification: true,
    openFileFromNotification: true,
    savedDir: externalDir.path + downloadDir
  );
}

Future<void> _checkOrCreateDownloadDirectory() async {
  Directory externalDir = await getExternalStorageDirectory();
  Directory _downloadDir = Directory(externalDir.path + downloadDir);
  if(await _downloadDir.exists()){
  }
  await _downloadDir.create(recursive: true);
}

Future<bool> _getPermission() async {
  PermissionStatus hasFilePerms = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  if(hasFilePerms == PermissionStatus.granted){
    return true;
  }
  Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  if(permissions[PermissionGroup.storage] == PermissionStatus.granted){
    return true;
  }
  return false;
}