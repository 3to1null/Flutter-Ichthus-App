import 'package:flutter/material.dart';
import '../models/appointment.dart';

class DetailsPage extends StatefulWidget {
  final Appointment appointment;
  DetailsPage(this.appointment);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: 120.0,
              elevation: 2.0,
              forceElevated: true,
              floating: false,
              pinned: true,
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(widget.appointment.subjects[0]),
              ),
            )
          ];
        },
        body: Container(),
      ),
    );
  }
}