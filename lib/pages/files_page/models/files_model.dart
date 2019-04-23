class File{
  String path;
  String pathTo;
  String name;
  bool isImage;
  int size;
  String fileId;
  String type;
  String lastModified;

  File({this.path, this.pathTo, this.name, this.isImage, this.size, this.type, this.lastModified, this.fileId});

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

}