import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {

  final List data;
  final onTapCallBack;

  SearchResults(this.data, this.onTapCallBack);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
        //NOTE TO SELF: ALWAYS SPECIFY ITEMCOUNT (if possible)
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          Map item = data[index];
          String name  = item['name'];
          String userCode = item['userCode'];
          return ListTile(
            //leading: Icon(Icons.offline_pin),
            title: Text(name != '' ? name : userCode),
            onTap: (){
              onTapCallBack(item);
            },
          );
        },
      ),
    );
  }
}