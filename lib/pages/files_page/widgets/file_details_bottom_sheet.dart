import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../widgets/information_list_tile.dart';

import '../functions/file_icon_picker.dart';
import '../functions/handle_file_open.dart';
import '../functions/handle_file_download.dart';
import '../models/files_model.dart';

class FileSheet extends StatelessWidget {

  final File file;
  FileSheet(this.file);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          FileSheetTopRow(file),
          Divider(),
          InformationListTile(leadingText: 'Laatst bewerkt:', titleText: file.lastModified),
          InformationListTile(leadingText: 'Bestandsgrootte:', titleText: file.sizeString),
          Divider(),
          ButtonRow(file)
        ],
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
  ButtonRow(this.file);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 3, child: Padding(padding: EdgeInsets.all(4.0), child: OpenButton(file))),
        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(4.0), child: DownloadButton(file))),
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

class DownloadButton extends StatelessWidget {
  final File file;
  DownloadButton(this.file);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Icon(Icons.file_download, color: Colors.white,),
      color: Colors.green,
      onPressed: (){handleFileDownload(file);},
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
      onPressed: (){},
    );
  }
}