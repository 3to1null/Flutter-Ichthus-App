import 'dart:async';
import 'package:flutter/material.dart';

import '../../../functions/request.dart';

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

  /// [isLoading] will show a indeterminate loading bar if its value is 1.0,
  /// will hide the loading bar if its set to null and will show a determinate
  /// loading bar if its value is between 0 and 1.
  ValueNotifier<double> isLoading = ValueNotifier<double>(null);

  Future<void> _fetchFilesAndFolders() async {
    if(this._fetchLock){
      return;
    }
    this._fetchLock = true;
    this.isLoading.value = this._fetchLock ? 1.0 : null;

    List<Map> filesAndFoldersMap;
    try{
       filesAndFoldersMap = await getFilesAndFolders(this.path).timeout(const Duration(seconds: 4));
    }on TimeoutException catch(error){
      print(error);
    }

    List<Folder> tempFolders = [];
    List<File> tempFiles = [];

    for(Map item in filesAndFoldersMap){
      if(item["dir"] == true){
        tempFolders.add(Folder(
          name: item["name"],
          path: item["path"],
          pathTo: item["pathTo"],
          size: item["size"] != "None" ? int.parse(item["size"]) : null,
          parent: this
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
          lastModified: item['last_modified'],
          parent: this
        ));
      }
    }
    this._childFolders = tempFolders;
    this._files = tempFiles;
    broadcastCachedFilesAndFolders();
    this._fetchLock = false;
    this.isLoading.value = this._fetchLock ? 1.0 : null;
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

  Future<void> delete() async {
    this.parent?.isLoading?.value = 1.0;
    await postDataToAPI('/files/rm', {'path': this.path});
    this.parent?.refresh();
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

  set loadingPercent(double percent){
    if(percent == 0.00 || percent == null){
      this.isLoading.value = null;
    }else{
      this.isLoading.value = percent;
    }
  }

  void closeAllStreams(){
    this._filesStreamController.close();
    this._childFolderStreamController.close();
  }

}