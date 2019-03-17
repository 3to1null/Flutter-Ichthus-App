import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 14.5),
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: AutoSizeText(titleText,
              style: Theme.of(context).textTheme.body2.copyWith(fontSize: 14.5),
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}