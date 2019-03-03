import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

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

class InformationListTile extends StatelessWidget {

  InformationListTile({this.titleText, this.leadingText});

  final String titleText;
  final String leadingText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: AutoSizeText(leadingText, 
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 15.0),
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(titleText,
              style: Theme.of(context).textTheme.body2.copyWith(fontSize: 15.0),
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}