import 'package:flutter/material.dart';

import '../functions/circle_color.dart';

class CijferSubjectMarks extends StatelessWidget {
  // final Map<String, List<Map<String, dynamic>>> subjectMarks;

  // CijferSubjectMarks(subjectMarks)
  //     : subjectMarks =
  //           Map<String, List<Map<String, dynamic>>>.from(subjectMarks);
  final Map subjectMarks;
  CijferSubjectMarks(this.subjectMarks);

  @override
  Widget build(BuildContext context) {
    print(subjectMarks);
    final List subjectMarksList = subjectMarks["list"];
    return ConstrainedBox(
      constraints: BoxConstraints.tightForFinite(height: 50.0),
      //TODO: Make a normal vertical indented list
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 40.0,
          itemCount: subjectMarksList.length,
          itemBuilder: (BuildContext context, index) {
            print(subjectMarksList[index]['cijfer']);
            return CircleAvatar(
                backgroundColor: circleColor(subjectMarksList[index]['cijfer']));
          },
        ),
      ),
    );
  }
}
