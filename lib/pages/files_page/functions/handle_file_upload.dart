import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:file_picker/file_picker.dart';

import '../models/files_page_model.dart';
import '../models/folder_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();
FlutterUploader uploader = FlutterUploader();

Future<void> handleFileUpload(Folder parentFolder) async {
  String filePath = await FilePicker.getFilePath(type: FileType.ANY);
  List<String> filePathList = filePath.split('/');
  String fileName = filePathList.removeLast();
  String savedDir = filePathList.join('/');
  String uploadURL = "https://drive.ichthuscollege.nl/remote.php/webdav/" + Uri.decodeComponent(parentFolder.path) + Uri.decodeComponent(fileName);

  uploader.enqueue(
    url: uploadURL,
    headers: {
      'Cookie': _filesPageModel.cookieString, 
      'Authorization': "Basic " + _filesPageModel.authToken  
    },
    showNotification: true,
    method: UplaodMethod.PUT,
    files: [FileItem(filename: fileName, savedDir: savedDir)]
  );

  final subscription = uploader.result.listen((result) {
      print(result);
  }, onError: (ex, stacktrace) {
    print(ex);
    print(stacktrace);
  });
}

