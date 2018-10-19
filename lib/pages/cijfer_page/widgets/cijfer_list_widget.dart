import 'package:flutter/material.dart';

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

        Color circleColor(Map<String, dynamic> cijferData){
          if(cijferData["average"] == '-'){
            return Colors.green;
          }else{
            num average = num.parse(cijferData["average"]);
            if(average >= 5.5){
              return Colors.green;
            }else{
              return Colors.red;
            }
          }
        }

        Map<String, dynamic> cijferData = cijferListData[index];
        return ExpansionTile(
          leading: CircleAvatar(
              backgroundColor: circleColor(cijferData),
              child: Text(
                cijferData["average"],
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.white),
              )),
          title: Text(cijferData['subject']),
          children: <Widget>[],
        );
      },
    );
  }
}
