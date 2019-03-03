import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {

  final List data;
  final onTapCallBack;

  SearchResults(this.data, this.onTapCallBack);

  @override
  Widget build(BuildContext context) {

    return data != null ? Container(
        child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          Map item = data[index];
          String name  = item['name'];
          String userCode = item['userCode'];
          bool isHistory = (item['h'] ?? false);
          //bool isStudent = (item['isStudent'] ?? true)
          return ListTile(
            leading: isHistory ? Icon(Icons.history) : Icon(Icons.person),
            title: Text(name != '' ? name : userCode),
            onTap: (){
              onTapCallBack(item);
            },
          );
        },
      ),
    ) : Padding(
      padding: EdgeInsets.all(10.0),
      child: Text("Er is kon geen verbinding worden gemaakt en er zijn geen opgeslagen roosters van andere mensen."),
    );
  }
}