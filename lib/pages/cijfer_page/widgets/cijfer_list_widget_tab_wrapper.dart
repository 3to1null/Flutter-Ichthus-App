import 'package:flutter/material.dart';
import 'cijfer_list_widget_stream_builder.dart';

class CijferListTabWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: <Widget>[
      CijferListStreamBuilder(1),
      CijferListStreamBuilder(2),
      CijferListStreamBuilder(3),
      CijferListStreamBuilder(4),
    ]);
  }
}