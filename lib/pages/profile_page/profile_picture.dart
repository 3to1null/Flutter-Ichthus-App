import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

import '../drawer/drawer_data_model.dart';
import '../../models/user_model.dart';

DrawerDataModel drawerDataModel = DrawerDataModel();
UserModel userModel = UserModel();

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {

  bool hasProfilePictureLink = false;
  Map profilePictureHeaders;
  String profilePictureUrl;

  @override
  Widget build(BuildContext context) {
    hasProfilePictureLink = drawerDataModel.hasProfilePictureLink;
    profilePictureHeaders = drawerDataModel.profilePictureHeaders;
    profilePictureUrl = drawerDataModel.profilePictureUrl;

    return Hero(
      tag: "ht_drawer_profile_picture",
      child: hasProfilePictureLink
          ? CircleAvatar(
              backgroundImage: AdvancedNetworkImage(profilePictureUrl,
                  header: {'Cookie': profilePictureHeaders["Cookie"]},
                  useDiskCache: true, loadFailedCallback: () {
                drawerDataModel.hasProfilePictureLink = false;
                setState(() {
                  hasProfilePictureLink = false;
                });
              }),
            )
          : CircleAvatar(
              child: Text(
                userModel.userName.substring(0, 1),
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.white70),
              ),
            ),
    );
  }
}