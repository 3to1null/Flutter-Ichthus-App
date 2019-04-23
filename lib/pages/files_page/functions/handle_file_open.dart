import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../widgets/image_full_screen_wrapper.dart';
import '../models/files_model.dart';
import '../models/files_page_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();

void handleFileOpen(File file, BuildContext context){
  if(file.isImage && file.size < 20 * 1024 * 1024){
    _displayImage(file, context);
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