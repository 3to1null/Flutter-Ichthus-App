import 'package:flutter/material.dart';

import '../../widgets/information_list_tile.dart';

class BottomInformationList extends StatelessWidget {

  BottomInformationList(this.profileData);

  final Map profileData;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        InformationListTile(leadingText: 'Leerlingnummer', titleText: profileData['Leerlingnummer']),
        InformationListTile(leadingText: 'Klas', titleText: profileData['Klas']),
        InformationListTile(leadingText: 'E-mailadres', titleText: profileData['E-mailadres']),
        Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),child: Divider()),
        InformationListTile(leadingText: 'Kluisnummer', titleText: profileData['Kluisnummer']),
        InformationListTile(leadingText: 'Sleutelnummer', titleText: profileData['Sleutelnummer']),
        Padding(padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),child: Divider()),
        InformationListTile(leadingText: 'Geboortedatum', titleText: profileData['Geboortedatum']),
        InformationListTile(leadingText: 'Woonplaats', titleText: profileData['Woonplaats']),
      ],      
    );
  }
}