import 'dart:async';
import 'package:flutter/material.dart';

import 'files_model.dart';
import '../functions/get_files.dart';

class Folder{
  Folder parent;
  String name;
  String path;
  String pathTo;
  int size;

  StreamController<List<Folder>> _childFolderStreamController;
  StreamController<List<File>> _filesStreamController;

  Folder({this.parent, this.name, this.path, this.pathTo, this.size}){
    _childFolderStreamController = StreamController.broadcast(onListen: (){_fetchFilesAndFolders();});
    _filesStreamController = StreamController.broadcast(onListen: (){_fetchFilesAndFolders();});
  }

  List<Folder> _childFolders;
  List<File> _files;

  bool _fetchLock = false;
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> _fetchFilesAndFolders() async {
    if(this._fetchLock){
      print("Already fetching -- returning!");
      return;
    }
    this._fetchLock = true;
    this.isLoading.value = this._fetchLock;

    print("-"*50);
    print("Fetching files and folders");
    print("-"*50);
    List<Map> filesAndFoldersMap = await getFilesAndFolders(this.path);

    List<Folder> tempFolders = [];
    List<File> tempFiles = [];

    for(Map item in filesAndFoldersMap){
      if(item["dir"] == true){
        tempFolders.add(Folder(
          name: item["name"],
          path: item["path"],
          pathTo: item["pathTo"],
          size: item["size"] != "None" ? int.parse(item["size"]) : null,
        ));
      }else{
        tempFiles.add(File(
          name: item["name"],
          path: item["path"],
          isImage: item['img'],
          pathTo: item["pathTo"],
          size: int.parse(item["size"]),
          type: item["type"],
          fileId: item['fileId'].toString(),
          lastModified: item['last_modified']
        ));
      }
    }
    this._childFolders = tempFolders;
    this._files = tempFiles;
    broadcastCachedFilesAndFolders();
    this._fetchLock = false;
    this.isLoading.value = this._fetchLock;
  }

  Future<void> refresh() async{
    _fetchFilesAndFolders();
  }

  bool broadcastCachedFilesAndFolders(){
    if(this._childFolders != null && this._files != null){
        this._childFolderStreamController.add(this._childFolders);
        this._filesStreamController.add(this._files);
      return true;
    }
    return false;
  }

  Stream<List<Folder>> get childFoldersStream {
    this._fetchFilesAndFolders();
    return _childFolderStreamController.stream;
  }

  Stream<List<File>> get filesStream {
    this._fetchFilesAndFolders();
    return _filesStreamController.stream;
  }

  bool get hasCachedFilesAndFolders {
    bool hasCache =  (this._childFolders != null && this._files != null);
    return hasCache;
  }

  List<Folder> get cachedChildFolders {
    if(this.hasCachedFilesAndFolders){
      print(this._childFolders);
      return this._childFolders;
    }
    return null;
  }

  List<File> get cachedFiles {
    if(this.hasCachedFilesAndFolders){
      return this._files;
    }
    return null;
  }

  void closeAllStreams(){
    this._filesStreamController.close();
    this._childFolderStreamController.close();
  }

}