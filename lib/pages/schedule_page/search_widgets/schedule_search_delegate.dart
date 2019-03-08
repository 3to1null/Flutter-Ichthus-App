import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import '../../../models/global_model.dart';

import '../../../functions/request.dart';
import 'schedule_search_offline.dart';

import '../../../widgets/loading_animation.dart';
import 'search_results_widget.dart';

class ScheduleSearchDelegate extends SearchDelegate {
  GlobalModel globalModel = GlobalModel();
  List dataLastResultsBuild;
  String lastQuery;
  bool lastQueryHadConnection = true;
  DateTime lastConnectionCheck = DateTime.now();
  String response;
  List returnList;
  Duration timeoutDuration = Duration(milliseconds: 2500);

  Future<List> _getResults(query) async {
    if(!lastQueryHadConnection && DateTime.now().difference(lastConnectionCheck).inMinutes < 1 ){
      timeoutDuration = Duration(milliseconds: 50);
    }
    if(query == lastQuery && dataLastResultsBuild != null){
      return dataLastResultsBuild;
    }
    try{
        response = await getDataFromAPI("/search", {"q": query}).timeout(timeoutDuration);
        returnList = json.decode(response);
    }catch(TimeoutException){
        print("search-online: failed");
        lastQueryHadConnection = false;
        returnList = globalModel.availableUserSchedulesOffline.where((userData) => foundQueryResult(userData, query)).toList();
    }
    lastQuery = query;
    return returnList;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Terug',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var future = _getResults(query);
    
    void onResultCallback(result){
      close(context, result);
    }

    return FutureBuilder<List>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.done:
            dataLastResultsBuild = snapshot.data;
            return SearchResults(dataLastResultsBuild, onResultCallback);
            break;
          default: 
            if(dataLastResultsBuild != null){
              return SearchResults(dataLastResultsBuild, onResultCallback);
            }else{
              return LoadingAnimation();
            }
        }

      },
    );
  }
}
