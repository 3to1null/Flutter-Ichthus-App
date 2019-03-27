import 'package:flutter/material.dart';
import 'cijfer_list_widget_stream_builder.dart';
import 'cijfer_list_widget_refresh_wrapper.dart';

class CijferListTabWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(children: <Widget>[
      CijferRefreshWrapper(CijferListStreamBuilder(1), 1),
      CijferRefreshWrapper(CijferListStreamBuilder(2), 2),
      CijferRefreshWrapper(CijferListStreamBuilder(3), 3),
      CijferRefreshWrapper(CijferListStreamBuilder(4), 4),
    ]);
  }
}