import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

import '../models/files_page_model.dart';
import '../models/files_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();

bool isDocumentType(File file, List<String> types){
  for(String type in types){
    if(file.name.endsWith(type)){
      return true;
    }
  }
  return false;
}

IconData _getIcon(File file){
  if(file.isImage){
    return MdiIcons.fileImage;
  }
  if(isDocumentType(file, ['.doc', '.docx', '.xls', '.xlsx', ".ppt", ".pptx", ".pptm", ".pub", ".xps"])){
    return MdiIcons.fileDocument;
  }
  if(isDocumentType(file, [".mp3", ".wav", ".ogg", ".3gp", ".flac", ".m4a", ".aac"])){
    return MdiIcons.fileMusic;
  }
  if(isDocumentType(file, [".webm", ".mkv", ".gifv", ".avi", ".mov", ".qt", ".wmv", ".mp4", ".m4p", ".m4v", ".mpeg"])){
    return MdiIcons.fileVideo;
  }
  if(isDocumentType(file, [".pdf"])){
    return MdiIcons.filePdf;
  }
  if(isDocumentType(file, ['.accdb', '.sqlite3', '.csv'])){
    return MdiIcons.database;
  }
  


  return Icons.insert_drive_file;
}

Widget fileIconPicker(File file, bool isBig, [bool forceUseLocalIcon=false]){
  if(file.isImage && !forceUseLocalIcon){
      return SmallPreviewImage(file, isBig);
  }

  IconData icon = _getIcon(file);

  if(isBig){
    return SizedBox(width: 72.0, height: 72.0, child: Icon(icon, color: Colors.black54, size: 72));
  }
  return SizedBox(width: 24.0, height: 24.0, child: Icon(icon, size: 24));
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
            cacheRule: CacheRule(maxAge: Duration(days: 3)),
            header: {
              'Cookie': _filesPageModel.cookieString, 
              'Authorization': _filesPageModel.authToken != null ? "Basic " + _filesPageModel.authToken : ""
               }
          ),
        ),
      ),
    );
  }
}