import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../functions/subjects_map.dart';
import '../../functions/random.dart';
import 'homework_details_page.dart';

class HomeworkList extends StatelessWidget {

  final List homework;

  HomeworkList(this.homework);

  String _buildUID(homeworkItem){
    return "${homeworkItem["subject"]}-${randomString(8)}";
  }

  void _openDetailsPage(BuildContext context, Map homeworkItem, String displayDate, String heroId){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context){
        return DetailsPage(homeworkItem, displayDate, heroId);
      }
    ));
  }

  @override
  Widget build(BuildContext context) {

    Widget _createHomeworkDateSliver(Map homework){
      dynamic generateTrailingIcon(homeworkItem){
        if(homeworkItem['is_custom'] == true){
          return Icon(Icons.change_history, color: Theme.of(context).accentColor);
        }
        if(homeworkItem['homework_made'] == true){
          return Icon(Icons.done, color: Colors.green,);
        }
        if(homeworkItem['test'] == "ja"){
          return Icon(Icons.library_books, color: Colors.redAccent);
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
              String heroId =_buildUID(homeworkItem);
              return Container(
                margin: EdgeInsets.all(0.0),
                child: Hero(
                  tag: heroId,
                  child: ListTile(
                    onTap: (){
                      _openDetailsPage(context, homeworkItem, homework['title'], heroId);
                    },
                    leading: Container(
                      width: 32.0,
                      height: 48.0,
                      child: Center(
                        child: Text(
                          homeworkItem['hour'].toString() != '69' ? homeworkItem['hour'].toString(): '', 
                          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                    trailing: generateTrailingIcon(homeworkItem),
                    title: Text(subjectsMap[homeworkItem['subject'].toLowerCase()] ?? homeworkItem['subject']),
                    subtitle: Text(
                      homeworkItem['homework_short'], 
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis),
                  ),
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