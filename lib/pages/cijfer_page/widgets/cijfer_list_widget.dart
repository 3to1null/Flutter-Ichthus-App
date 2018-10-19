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
      itemBuilder: (BuildContext context, int index){
        return Text(cijferListData[index].toString());
      },
    ); 
  }
}