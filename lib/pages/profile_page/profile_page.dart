import 'package:flutter/material.dart';

import 'profile_picture.dart';
import 'bottom_information_card.dart';

import '../drawer/drawer_data_model.dart';
import '../../models/user_model.dart';

DrawerDataModel drawerDataModel = DrawerDataModel();
UserModel userModel = UserModel();

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: BackButton(
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
              height: MediaQuery.of(context).size.height * 0.095,
              width: MediaQuery.of(context).size.height * 0.095,
              child: ProfilePicture(),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.24,
              padding: EdgeInsets.fromLTRB(
                24.0, 0, 24.0,
                MediaQuery.of(context).size.height * 0.025
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                userModel.userName,
                style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
              )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(
                accentColor: bgColor,                
              ),
              child: BottomInformationCard()
            ),
          ),
        ],
      ),
    );
  }
}