import 'package:flutter/material.dart';

import '../models/files_model.dart';

IconData fileIconPicker(File file){
  IconData tileIcon = Icons.insert_drive_file;
  if(file.isImage != null && file.isImage){
    tileIcon = Icons.image;
  }
  return tileIcon;
}