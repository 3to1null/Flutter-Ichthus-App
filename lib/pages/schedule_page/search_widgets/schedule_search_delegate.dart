import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';

import '../../../functions/request.dart';

import '../../../widgets/loading_animation.dart';
import 'search_results_widget.dart';

class ScheduleSearchDelegate extends SearchDelegate {
  List dataLastResultsBuild;

  Future<List> _getResults(query) async {
    String response = await getDataFromAPI("/search", {"q": query});
    List decodedResponse = json.decode(response);
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
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var future = _getResults(query);
    return FutureBuilder<List>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState){
          case ConnectionState.done:
            dataLastResultsBuild = snapshot.data;
            return SearchResults(dataLastResultsBuild);
            break;
          default: 
            if(dataLastResultsBuild != null){
              return SearchResults(dataLastResultsBuild);
            }else{
              return LoadingAnimation();
            }
        }

      },
    );
  }
}
