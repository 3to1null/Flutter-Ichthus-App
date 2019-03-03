import 'package:flutter/material.dart';
import 'dart:math';

import 'cijfers_detail_sheet.dart';

import '../../../functions/random_string.dart';
import '../functions/circle_color.dart';

class CijferSubjectMarks extends StatelessWidget {
  final Map subjectMarks;
  CijferSubjectMarks(this.subjectMarks);

  // void _openMarksDetailPage(Map subjectMarksItem, context, String uniqueHeroTag){
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (BuildContext context){
  //       return MarksDetailPage(subjectMarksItem, uniqueHeroTag);
  //     }
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    final List subjectMarksList = subjectMarks["cijfers"]["list"];
    return ConstrainedBox(
      constraints: BoxConstraints.tightForFinite(
          height: max(40.0, min(260.0, subjectMarksList.length * 62.0))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: subjectMarksList.length > 0 ? ListView.builder(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(0.0),
          itemCount: subjectMarksList.length,
          itemBuilder: (BuildContext context, index) {
            Map subjectMarksItem = subjectMarksList[index];
            return ListTile(
              leading: CircleAvatar(
                  child: Text(
                    subjectMarksItem['cijfer'],
                    style: Theme.of(context)
                        .textTheme
                        .body2
                        .copyWith(color: Colors.white),
                  ),
                  backgroundColor: circleColor(subjectMarksItem['cijfer'])),
              title: Text(
                subjectMarksItem['details']['Beschrijving'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: (){openMarksBottomSheet(context, subjectMarksItem);},
            );
          },
        ) : Text("Er zijn nog geen cijfers beschikbaar voor ${subjectMarks["subject"]}"),
      ),
    );
  }
}
