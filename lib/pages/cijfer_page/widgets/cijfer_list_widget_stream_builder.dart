import 'package:flutter/material.dart';

import '../../../widgets/loading_animation.dart';
import 'cijfer_list_widget.dart';

import '../functions/get_cijfers.dart';

class CijferListStreamBuilder extends StatelessWidget {
  final int period;
  CijferListStreamBuilder(this.period);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getCijfers(period),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none: return LoadingAnimation();
          case ConnectionState.waiting: return LoadingAnimation();
          case ConnectionState.active: return snapshot.data[0]['data'] != false ? CijferList(snapshot.data) : LoadingAnimation();
          case ConnectionState.done: return snapshot.data[0]['data'] != false ? CijferList(snapshot.data) : LoadingAnimation();
        }
      },
    );
  }
}