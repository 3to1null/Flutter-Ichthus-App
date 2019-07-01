import '../../../functions/request.dart';
import './folder_model.dart';

class File{
  String path;
  String pathTo;
  String name;
  bool isImage;
  int size;
  String fileId;
  String type;
  String lastModified;
  Folder parent;

  File({this.path, this.pathTo, this.name, this.isImage, this.size, this.type, this.lastModified, this.fileId, this.parent});

  String get sizeString{
    if(this.size > 1024 * 1024){
      return (this.size / (1024 * 1024)).toStringAsFixed(2) + " MB";
    }
    if(this.size > 1024){
      return (this.size / (1024)).toStringAsFixed(2) + " KB";
    }
    return this.size.toString() + " B";
  }

  String get downloadURL{
    return "https://drive.ichthuscollege.nl/remote.php/webdav/" + Uri.decodeComponent(this.path);
  }

  String customPreviewURL(int width, int height){
    if(!this.isImage){
      return null;
    }
    return "https://drive.ichthuscollege.nl/core/preview?fileId=" + this.fileId + "&x=" + width.toString() + "&y=" + height.toString(); 
  }

  String get previewURL{
    return this.customPreviewURL(175, 175);
  }

  bool get canOpen{
    return this.size < 25 * 1024 * 1024;
  }

  Future<void> delete() async {
    this.parent?.isLoading?.value = 1.0;
    await postDataToAPI('/files/rm', {'path': this.path});
    this.parent?.refresh();
  }

}