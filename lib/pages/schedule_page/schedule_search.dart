import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';
import 'dart:convert';

import '../../functions/request.dart';

class ScheduleSearch extends StatefulWidget {
  @override
  _ScheduleSearchState createState() => _ScheduleSearchState();
}

class _ScheduleSearchState extends State<ScheduleSearch> {
  @override
  Widget build(BuildContext context) {
    return MaterialSearch(
      placeholder: 'Zoek een rooster',

      getResults: (String criteria) async {
        String response = await getDataFromAPI("/search", {"q": criteria});
        List responseDecoded = json.decode(response);
        return responseDecoded.map((searchObject) => MaterialSearchResult<String>(
          value: searchObject["userCode"],
          text: searchObject["name"],
        )).toList();
      },

      onSelect: (selected){
        print(selected);
      },
    );
  }
}