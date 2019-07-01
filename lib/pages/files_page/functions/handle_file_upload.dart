import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../models/files_page_model.dart';
import '../models/folder_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();
Dio dio = Dio();

Future<void> handleFileUpload(Folder parentFolder) async {
  int rateLimiter = 0;
  int updateRate = 1;

  File fileToUpload = await FilePicker.getFile(type: FileType.ANY);
  String fileName = fileToUpload.path.split("/").last;
  String uploadURL = "https://drive.ichthuscollege.nl/remote.php/webdav/" + Uri.decodeComponent(parentFolder.path) + Uri.decodeComponent(fileName);
  await dio.request(
    uploadURL,
    data: fileToUpload.openRead(),
    options: Options(
      method: "PUT",
      contentType: ContentType("Binary", "Binary"),
      headers: {
        HttpHeaders.contentLengthHeader: await fileToUpload.length(),
        'Cookie': _filesPageModel.cookieString, 
        'Authorization': "Basic " + _filesPageModel.authToken  ,
        'Content-Disposition': 'attachment; filename="$fileName"'
      },
    ),
    onSendProgress: (int sent, int total){
      if(rateLimiter == 0){
        parentFolder.loadingPercent = (sent/total);
      }
      rateLimiter++;
      if(rateLimiter == updateRate){
        rateLimiter = 0;
      }
    }
  );

  parentFolder.loadingPercent = null;
  parentFolder.refresh();
}

