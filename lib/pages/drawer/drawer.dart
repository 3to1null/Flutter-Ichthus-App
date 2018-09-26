import 'package:flutter/material.dart';

import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

import 'get_link_profile_picture.dart';
import 'logout_guider.dart';

import 'drawer_data_model.dart';
import '../../models/user_model.dart';

class CompleteDrawer extends StatefulWidget {
  @override
  _CompleteDrawerState createState() => _CompleteDrawerState();
}

class _CompleteDrawerState extends State<CompleteDrawer> {
  bool hasProfilePictureLink = false;
  Map profilePictureHeaders;
  String profilePictureUrl;

  DrawerDataModel drawerDataModel = DrawerDataModel();

  void updateStateToLoadProfilePicture(Map headers, String url) {
    drawerDataModel.hasProfilePictureLink = true;
    drawerDataModel.profilePictureUrl = url;
    drawerDataModel.profilePictureHeaders = headers;
    setState(() {
      hasProfilePictureLink = true;
      profilePictureUrl = url;
      profilePictureHeaders = headers;
    });
  }

  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    hasProfilePictureLink = drawerDataModel.hasProfilePictureLink;
    profilePictureHeaders = drawerDataModel.profilePictureHeaders;
    profilePictureUrl = drawerDataModel.profilePictureUrl;

    if (!hasProfilePictureLink) {
      getLinkToProfilePicture(updateStateToLoadProfilePicture);
    }

    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userModel.userName),
            accountEmail:
                Text("${userModel.userGroup} | ${userModel.userCode}"),
            currentAccountPicture: hasProfilePictureLink
                ? CircleAvatar(
                    backgroundImage: AdvancedNetworkImage(profilePictureUrl,
                        header: {'Cookie': profilePictureHeaders["Cookie"]},
                        useDiskCache: false, loadFailedCallback: () {
                      drawerDataModel.hasProfilePictureLink = false;
                      setState(() {
                        hasProfilePictureLink = false;
                      });
                    }),
                  )
                : CircleAvatar(
                    //TODO: Get initials
                    child: Text("NK"),
                  ),
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Uitloggen"),
              onTap: (){
                logoutGuider(context);
              }
            )
        ],
      ),
    );
  }
}
