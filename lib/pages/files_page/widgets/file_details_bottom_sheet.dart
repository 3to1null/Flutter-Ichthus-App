import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../../widgets/information_list_tile.dart';

import '../functions/file_icon_picker.dart';
import '../functions/handle_file_open.dart';
import '../functions/handle_file_download.dart';
import '../models/files_model.dart';
import '../models/files_page_model.dart';

FilesPageModel _filesPageModel = FilesPageModel();

enum LoadingState {
  LOADING_WAIT,
  LOADING,
  NOT_LOADING,
  COMPLETE
}

class FileSheet extends StatefulWidget {

  final File file;
  FileSheet(this.file);

  @override
  _FileSheetState createState() => _FileSheetState();
}

class _FileSheetState extends State<FileSheet> {

  LoadingState _loadingState = LoadingState.NOT_LOADING;
  int downloadProgress = 0;

  void callback(LoadingState loadingState, int process){
    setState(() {
      _loadingState = loadingState;
      downloadProgress = process;
    });
  }

  Widget loadingIndicator(){
    if(_loadingState == LoadingState.LOADING){
      return LinearProgressIndicator(value: downloadProgress / 100);
    }
    if(_loadingState == LoadingState.LOADING_WAIT){
      return LinearProgressIndicator();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0)
          )
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            FileSheetTopRow(widget.file),
            loadingIndicator(),
            Divider(),
            InformationListTile(leadingText: 'Laatst bewerkt:', titleText: widget.file.lastModified),
            InformationListTile(leadingText: 'Bestandsgrootte:', titleText: widget.file.sizeString),
            Divider(),
            ButtonRow(widget.file, callback)
          ],
        ),
      ),
    );
  }
}

class FileSheetTopRow extends StatelessWidget {

  final File file;
  FileSheetTopRow(this.file);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3, 
          child: fileIconPicker(file, true)
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: <Widget>[
              AutoSizeText(file.name, style: Theme.of(context).textTheme.headline, maxLines: 2, minFontSize: 18.0),
              Container(height: 4),
              AutoSizeText(file.pathTo, style: Theme.of(context).textTheme.headline.copyWith(fontSize: 14.0, color: Colors.black54),)
            ],
          ),
        )
      ],
    );
  }
}

class ButtonRow extends StatelessWidget {
  final File file;
  final parentSetStateCallback;
  ButtonRow(this.file, this.parentSetStateCallback);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: file.canOpen ? <Widget>[
        Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(4.0), child: OpenButton(file))),
        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(4.0), child: DownloadButton(file, parentSetStateCallback))),
        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(4.0), child: DeleteButton(file)))
      ] :
      <Widget>[
        Expanded(flex: 4, child: Padding(padding: EdgeInsets.all(4.0), child: DownloadButton(file, parentSetStateCallback))),
        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(4.0), child: DeleteButton(file)))
      ],
    );
  }
}

class OpenButton extends StatelessWidget {
  final File file;
  OpenButton(this.file);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Icon(Icons.open_in_new, color: Colors.white,),
      color: Colors.green,
      onPressed: (){handleFileOpen(file, context);},
    );
  }
}

class DownloadButton extends StatefulWidget {
  final File file;
  final Function setStateCallback;
  DownloadButton(this.file, this.setStateCallback);

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isDownloading = false;

  void createCallBack(String downloadId){
    Function downloadCallback = (String id, DownloadTaskStatus status, int progress){
      if(id != downloadId){
        return;
      }
      if(status == DownloadTaskStatus.enqueued || status == DownloadTaskStatus.undefined || status == DownloadTaskStatus.paused){
        setState(() {
         isDownloading = true; 
        });
        widget.setStateCallback(LoadingState.LOADING_WAIT, 0);
        return;
      }
      if(status == DownloadTaskStatus.running){
        widget.setStateCallback(LoadingState.LOADING, progress);
        return;
      }
      if(status == DownloadTaskStatus.complete || status == DownloadTaskStatus.failed || status == DownloadTaskStatus.canceled){
        setState(() {
         isDownloading = false; 
        });
        widget.setStateCallback(LoadingState.COMPLETE, progress);
        return;
      }
    };

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void initState() {
    super.initState();
    if(_filesPageModel.filesDownloading.containsKey(widget.file.fileId)){
      createCallBack(_filesPageModel.filesDownloading[widget.file.fileId]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Icon(Icons.file_download, color: Colors.white,),
      color: Colors.green,
      onPressed: isDownloading ? null : () async {
        String downloadId = await handleFileDownload(widget.file);
        createCallBack(downloadId);
      },
    );
  }
}

class DeleteButton extends StatelessWidget {
  final File file;
  DeleteButton(this.file);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Icon(Icons.delete, color: Colors.white,),
      color: Colors.red,
      onPressed: (){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Center(child: Text(file.name, style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w600))),
              content: Text("Weet je zeker dat je deze map en alle bestanden erin volledig wilt verwijderen?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Annuleer'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Verwijder'),
                  textColor: Colors.red,
                  onPressed: (){
                    file.delete();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
        );
      },
    );
  }
}