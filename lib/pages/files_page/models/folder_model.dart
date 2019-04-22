import 'files_model.dart';
import '../functions/get_files.dart';

class Folder{
  Folder parent;
  String name;
  String path;
  String pathTo;
  int size;

  Folder({this.parent, this.name, this.path, this.pathTo, this.size});

  List<Folder> _childFolders;
  List<File> _files;

  Future<void> _fetchFilesAndFolders() async {
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
          pathTo: item["pathTo"],
          size: int.parse(item["size"]),
          type: item["type"]
        ));
      }
    }
    this._childFolders = tempFolders;
    this._files = tempFiles;
  }

  Future _futureVarFetchFilesAndFolders;

  Future<List<Folder>> get childFolders async {
    if(this._childFolders != null){
      return this._childFolders;
    }
    if(this._futureVarFetchFilesAndFolders == null){
      _futureVarFetchFilesAndFolders = this._fetchFilesAndFolders();
    }
    await _futureVarFetchFilesAndFolders;
    return this._childFolders;
  }

  Future<List<File>> get files async {
    if(this._files != null){
      return this._files;
    }
    if(this._futureVarFetchFilesAndFolders == null){
      this._futureVarFetchFilesAndFolders = this._fetchFilesAndFolders();
    }
    await this._futureVarFetchFilesAndFolders;
    return this._files;
  }

  Future<void> refresh() async{
    this._futureVarFetchFilesAndFolders = this._fetchFilesAndFolders();
    await this._futureVarFetchFilesAndFolders;
  }

}