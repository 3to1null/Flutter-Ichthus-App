import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../../widgets/information_list_tile.dart';


import '../functions/circle_color.dart';

void openMarksBottomSheet(BuildContext context, Map subjectMarksItem){
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context){
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 32.0,
                      child: Text(
                        subjectMarksItem['cijfer'],
                        style: Theme.of(context)
                            .textTheme
                            .body2
                            .copyWith(color: Colors.white, fontSize: 25.0),
                      ),
                      backgroundColor: circleColor(subjectMarksItem['cijfer'])
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: AutoSizeText(
                    subjectMarksItem['details']['Beschrijving'],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.title,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            subjectMarksItem['isBubble'] ? BubbleList(subjectMarksItem['bubbleSTR']) : Container(),
            subjectMarksItem['isBubble'] ? Divider() : Container(),
            InformationListTile(leadingText: 'Weging:', titleText: subjectMarksItem['details']['Weging']),
            InformationListTile(leadingText: 'Toetssoort:', titleText: subjectMarksItem['details']['Toetssoort']),
            InformationListTile(leadingText: 'Toetscode:', titleText: subjectMarksItem['details']['Toetscode']),
            subjectMarksItem['details'].containsKey('Herkansing') ? InformationListTile(leadingText: 'Herkansing:', titleText: subjectMarksItem['details']['Herkansing']) : Container()
          ],
        ),
      );
    }
  );
}

class BubbleList extends StatelessWidget {

  final String bubbleString;

  BubbleList(this.bubbleString);

  @override
  Widget build(BuildContext context) {
    List bubbleList = this.bubbleString.split(', ').toList();
    return Container(
      height: 60,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: bubbleList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: CircleAvatar(
              radius: 20.0,
              child: Text(
                bubbleList[index],
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.white, fontSize: 14.0),
              ),
              backgroundColor: circleColor(bubbleList[index])
            ),
          );
        },
      ),
    );
  }
}