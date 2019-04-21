import 'package:flutter/material.dart';
import '../models/folder_model.dart';

class FolderGridCard extends StatelessWidget {

  final Folder folder;

  FolderGridCard({this.folder});

  @override
  Widget build(BuildContext context) {

    IconData icon;
    switch (folder.path) {
      case "/HomeDrive (H)/": icon = Icons.laptop_windows; break;
      case "__laad__overige__fraignt__api": icon = Icons.cloud; break;
      default: icon = Icons.folder;
    }

    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 48.0, color: Colors.black54,),
          SizedBox(height: 8.0),
          Text(folder.name, textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
