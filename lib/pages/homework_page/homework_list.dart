import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class HomeworkList extends StatelessWidget {

  final List homework;

  HomeworkList(this.homework);

  @override
  Widget build(BuildContext context) {

    Widget _createHomeworkDateSliver(Map homework){
      dynamic generateTrailingIcon(homeworkItem){
        if(homeworkItem['homework_made'] == true){
          return Icon(Icons.done, color: Colors.green,);
        }
        if(homeworkItem['test'] == "ja"){
          return Icon(Icons.library_books, color: Theme.of(context).accentColor);
        }
      }

      return SliverStickyHeaderBuilder(
        builder: (context, state) => Card(
          child: Container(
            height: 36.0,
            padding: EdgeInsets.only(left: 72.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                homework['title'],
                style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
              ),
            ),
          ),
          margin: EdgeInsets.all(0.0),
          elevation: state.isPinned ? 4 : 0,
          shape: RoundedRectangleBorder(),
          color: Theme.of(context).primaryColor,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int childIndex) {
              Map<String, dynamic> homeworkItem = homework['items'][childIndex];
              return Container(
                margin: EdgeInsets.all(0.0),
                child: ListTile(
                  leading: Container(
                    width: 32.0,
                    height: 48.0,
                    child: Center(
                      child: Text(
                        homeworkItem['hour'], 
                        style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  trailing: generateTrailingIcon(homeworkItem),
                  title: Text(homeworkItem['subject']),
                  subtitle: Text(
                    homeworkItem['homework'], 
                    maxLines: 2, 
                    overflow: TextOverflow.ellipsis),
                ),
              );
            },
            childCount: homework['items'].length
          ),
        ),
      );
    }

    List<Widget> _buildSlivers(){
      List<Widget> returnSlivers = [];

      for(Map homework_date_data in this.homework){
        returnSlivers.add(_createHomeworkDateSliver(homework_date_data));
      }

      return returnSlivers;
    }

    return CustomScrollView(
      slivers: _buildSlivers(),
    );
  }

}