import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../widgets/information_list_tile.dart';

import '../models/folder_model.dart';

class FolderSheet extends StatelessWidget {
  final Folder folder;
  FolderSheet(this.folder);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        height: 220,
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
            FolderSheetTopRow(folder),
            Divider(),
            ButtonRow(folder)
          ],
        ),
      ),
    );
  }
}

class FolderSheetTopRow extends StatelessWidget {

  final Folder folder;
  FolderSheetTopRow(this.folder);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3, 
          child: SizedBox(width: 72.0, height: 72.0, child: Icon(Icons.folder, color: Colors.black54, size: 72))
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: <Widget>[
              AutoSizeText(folder.name, style: Theme.of(context).textTheme.headline, maxLines: 2, minFontSize: 18.0),
              Container(height: 4),
              AutoSizeText(folder.pathTo, style: Theme.of(context).textTheme.headline.copyWith(fontSize: 14.0, color: Colors.black54)),
            ],
          ),
        )
      ],
    );
  }
}

class ButtonRow extends StatelessWidget {
  final Folder folder;
  ButtonRow(this.folder);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(4.0), child: DeleteButton(folder)))
      ],
    );
  }
}

class DeleteButton extends StatelessWidget {
  final Folder folder;
  DeleteButton(this.folder);

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
              title: Center(child: Text(folder.name, style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w600))),
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
                    folder.delete();
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