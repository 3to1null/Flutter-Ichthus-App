import 'package:flutter/material.dart';

import '../../widgets/loading_animation.dart';

import '../../functions/get_profile_info.dart';
import 'bottom_information_list.dart';

class BottomInformationCard extends StatefulWidget {
  @override
  BottomInformationCardState createState() {
    return new BottomInformationCardState();
  }
}

class BottomInformationCardState extends State<BottomInformationCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
          )
      ),
      margin: EdgeInsets.all(0),
      elevation: 3.0,
      child: Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.24,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.orangeAccent),
            child: FutureBuilder(
              future: getProfileInfo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.none: return LoadingAnimation();
                  case ConnectionState.waiting: return LoadingAnimation();
                  case ConnectionState.active: return LoadingAnimation();
                  case ConnectionState.done: return BottomInformationList(snapshot.data);
                }
              },
            ),
          )
        ),
      ),
    );
  }
}