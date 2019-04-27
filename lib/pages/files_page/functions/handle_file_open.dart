import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/image_full_screen_wrapper.dart';
import '../models/files_model.dart';
import '../models/files_page_model.dart';
import 'handle_file_download.dart';
import 'package:open_file/open_file.dart';

FilesPageModel _filesPageModel = FilesPageModel();

void handleFileOpen(File file, BuildContext context){
  if(file.isImage){
    _displayImage(file, context);
  }else{
    _openFile(file);
  }
}

void _displayImage(File file, BuildContext context){
  Navigator.push(context, MaterialPageRoute(
    builder: (context) => FullScreenWrapper(
      imageProvider: AdvancedNetworkImage(
        file.downloadURL, 
        header: {
          'Cookie': _filesPageModel.cookieString, 
          'connection': "close",
          'Authorization': "Basic " + _filesPageModel.authToken  
        }
      ),
    )
  ));
}

Future<void> _openFile(File file) async {
  StreamController<bool> downloadingCallbackStreamController = StreamController();

  String downloadTaskId = await handleFileDownload(file);

  Function downloadCallback = (String id, DownloadTaskStatus status, int progress){
    if(id != downloadTaskId){
      return;
    }
    if(status == DownloadTaskStatus.complete || status == DownloadTaskStatus.failed || status == DownloadTaskStatus.canceled){
      downloadingCallbackStreamController.add(true);
      return;
    }
  };

  FlutterDownloader.registerCallback(downloadCallback);

  await downloadingCallbackStreamController.stream.firstWhere((bool hasDownloaded) => hasDownloaded);
  downloadingCallbackStreamController.close();

  Directory externalDir = await getExternalStorageDirectory();
  String downloadPath = externalDir.path + downloadDir + '/' + file.name;
  print(downloadPath);
  OpenFile.open(downloadPath);
}