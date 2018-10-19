import 'dart:convert';

class DrawerDataModel {
  static final DrawerDataModel _drawerDataModel = new DrawerDataModel._internal();

  factory DrawerDataModel() {
    return _drawerDataModel;
  }

  DrawerDataModel._internal();

  bool hasProfilePictureLink = false;
  Map profilePictureHeaders;
  String profilePictureUrl;

  String currentActivePage;

}