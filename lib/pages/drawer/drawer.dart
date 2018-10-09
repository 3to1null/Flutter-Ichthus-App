import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

import 'get_link_profile_picture.dart';
import 'logout_guider.dart';

import 'drawer_data_model.dart';
import '../../models/user_model.dart';

class CompleteDrawer extends StatefulWidget {
  CompleteDrawer(this.fbAnalytics, this.fbObserver);

  final FirebaseAnalytics fbAnalytics;
  final FirebaseAnalyticsObserver fbObserver;

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

    //log draweropen
    widget.fbAnalytics.logEvent(
      name: 'drawer_open'
    );

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
                    child: Text(
                      userModel.userName.substring(0, 1),
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(color: Colors.white70),
                    ),
                  ),
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Uitloggen"),
              onTap: () {
                logoutGuider(context);
              })
        ],
      ),
    );
  }
  
}
