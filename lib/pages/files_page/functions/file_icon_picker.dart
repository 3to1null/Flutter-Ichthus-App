import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

import '../models/files_page_model.dart';
import '../models/files_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();

Widget fileIconPicker(File file, bool isBig, [bool forceUseLocalIcon=false]){
  if(file.isImage){
    if(!forceUseLocalIcon){
      return SmallPreviewImage(file, isBig);
    }
    if(isBig){
      return Icon(Icons.photo, color: Colors.black54, size: 72);
    }
    return Icon(Icons.photo, size: 24);
  }
  if(isBig){
    return Icon(Icons.insert_drive_file, color: Colors.black54, size: 72);
  }
  return Icon(Icons.insert_drive_file, size: 24);
}

class SmallPreviewImage extends StatelessWidget {
  final File file;
  final bool isBig;
  SmallPreviewImage(this.file, this.isBig);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isBig ? EdgeInsets.all(16.0) : EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: TransitionToImage(
          placeholder: fileIconPicker(file, isBig, true),
          loadingWidget: fileIconPicker(file, isBig, true),
          image: AdvancedNetworkImage(
            file.previewURL,
            useDiskCache: true,
            cacheRule: CacheRule(maxAge: Duration(days: 1)),
            header: {
              'Cookie': _filesPageModel.cookieString, 
              'Authorization': "Basic " + _filesPageModel.authToken  
            }
          ),
        ),
      ),
    );
  }
}