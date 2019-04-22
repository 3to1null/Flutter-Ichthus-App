import 'folder_model.dart';

class File{
  String path;
  String pathTo;
  String name;
  bool isImage;
  int size;
  String type;
  String lastModified;

  File({this.path, this.pathTo, this.name, this.isImage, this.size, this.type, this.lastModified});

  String get sizeString{
    if(this.size > 1024 * 1024){
      return (this.size / (1024 * 1024)).toStringAsFixed(2) + " MB";
    }
    if(this.size > 1024){
      return (this.size / (1024)).toStringAsFixed(2) + " KB";
    }
    return this.size.toString() + " B";
  }

}