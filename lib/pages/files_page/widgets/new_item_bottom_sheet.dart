import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../functions/handle_new_item.dart';
import '../functions/handle_file_upload.dart';
import '../models/folder_model.dart';


class NewItemSheet extends StatelessWidget {
  final Folder folder;
  final BuildContext pageContext;

  NewItemSheet(this.folder, this.pageContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: Color(0xFF737373),
      child: new Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
          )
        ),
        child: Material(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 120,
                child: InkWell(
                  customBorder: CircleBorder(),
                  child: ItemCircle(itemIcon: MdiIcons.folderPlusOutline, text: 'Nieuwe map'),
                  onTap: (){
                    handleNewFolder(context, folder);
                  },
                ),
              ),
              Container(
                width: 120,
                child: InkWell(
                  customBorder: CircleBorder(),
                  child: ItemCircle(itemIcon: Icons.file_upload, text: 'Upload bestand'),
                  onTap: (){
                    handleFileUpload(folder);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCircle extends StatelessWidget {
  final IconData itemIcon;
  final String text;

  ItemCircle({this.itemIcon, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(90)),
            border: Border.all(color: Colors.black54)
          ),
          child: Icon(itemIcon),  
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        )
      ],
    );
  }
}