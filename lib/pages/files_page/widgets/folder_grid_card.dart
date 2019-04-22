import 'package:flutter/material.dart';

import '../../../functions/random_string.dart';

import '../models/folder_model.dart';
import '../functions/open_new_page.dart';

class FolderGridCard extends StatelessWidget {

  final Folder folder;

  FolderGridCard({this.folder});

  @override
  Widget build(BuildContext context) {

    IconData icon;
    switch (folder.path) {
      case "/HomeDrive (H)/": icon = Icons.laptop_windows; break;
      case "__fraignt__api__laad_overige": icon = Icons.cloud; break;
      default: icon = Icons.folder;
    }

    String heroTag = folder.path + randomString(12);

    return Hero(
      tag: heroTag,
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(16.0),
        child: InkWell(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 48.0, color: Colors.black54),
              Container(height: 8.0),
              Text(folder.name, textAlign: TextAlign.center)
            ],
          ),
          onTap: (){openFolderPage(context, folder, heroTag);},
        ),
      ),
    );
  }
}
