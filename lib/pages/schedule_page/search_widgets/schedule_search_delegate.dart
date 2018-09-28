import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import '../../../functions/request.dart';

import '../../../widgets/loading_animation.dart';
import 'search_results_widget.dart';

class ScheduleSearchDelegate extends SearchDelegate {
  List dataLastResultsBuild;
  String lastQuery;

  Future<List> _getResults(query) async {
    if(query == lastQuery && dataLastResultsBuild != null){
      return dataLastResultsBuild;
    }
    String response = await getDataFromAPI("/search", {"q": query});
    List decodedResponse = json.decode(response);
    lastQuery = query;
    return decodedResponse;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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
