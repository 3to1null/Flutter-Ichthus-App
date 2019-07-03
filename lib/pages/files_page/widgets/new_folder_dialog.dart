import 'package:flutter/material.dart';

import '../functions/create_new_folder.dart';
import '../models/folder_model.dart';

class NewFolderDialog extends StatefulWidget {
  @override
  _NewFolderDialogState createState() => _NewFolderDialogState();

  final BuildContext pageContext;
  final Folder parentFolder;
  NewFolderDialog(this.pageContext, this.parentFolder);
}

class _NewFolderDialogState extends State<NewFolderDialog> {
  TextEditingController _folderNameTextController = TextEditingController();
  String errorMessage;
  List<String> folderNames;
  bool hasTypedFirstChar = false;

  @override
  void initState() {
    folderNames = widget.parentFolder.cachedChildFolders.map((f) => f.name).toList();
    _folderNameTextController.addListener((){
      String currentValue = _folderNameTextController.text;
      if(currentValue.length > 0){
        hasTypedFirstChar = true;
      }
      if(folderNames.contains(currentValue)){
        setState(() {
         errorMessage = "Deze naam is al in gebruik."; 
        });
      }else if(currentValue == "" && hasTypedFirstChar){
        setState(() {
         errorMessage = "Vul een naam in voor de map."; 
        });
      }else{
        setState(() {
         errorMessage = null; 
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {Navigator.of(widget.pageContext).pop(); return true;},
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Center(child: Text('Nieuwe map', style: Theme.of(context).textTheme.subhead.copyWith(fontWeight: FontWeight.w600))),
          content: TextField(
            controller: _folderNameTextController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0),
            decoration: InputDecoration(
              errorText: errorMessage,
              contentPadding: EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 8.0),
              fillColor: Colors.black12,
              filled: true,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text('Opslaan'),
              textColor: Theme.of(context).primaryColor,
              onPressed: errorMessage != null ? null : () {
                createNewFolder(widget.parentFolder, _folderNameTextController.text);
                Navigator.of(context).pop();
                Navigator.of(widget.pageContext).pop();
              },
            )
          ],
        ),
      );
  }
}