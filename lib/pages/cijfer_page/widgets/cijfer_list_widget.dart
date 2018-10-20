import 'package:flutter/material.dart';

import 'cijfer_subject_marks.dart';

import '../functions/circle_color.dart';

class CijferList extends StatelessWidget {
  final List<Map<String, dynamic>> cijferListData;

  CijferList(this.cijferListData);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: cijferListData.length,
      padding: EdgeInsets.all(8.0),
      //itemExtent: 20.0,
      itemBuilder: (BuildContext context, int index) {
        Map<String, dynamic> cijferData = cijferListData[index];
        return ExpansionTile(
          leading: CircleAvatar(
              backgroundColor: circleColor(cijferData['average']),
              child: Text(
                cijferData["average"],
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.white),
              )),
          title: Text(cijferData['subject']),
          children: <Widget>[CijferSubjectMarks(cijferData)],
        );
      },
    );
  }
}
