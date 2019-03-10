import 'package:flutter/material.dart';

import '../../../widgets/loading_animation.dart';
import 'cijfer_list_widget.dart';

import '../functions/get_cijfers.dart';

Widget chooseCijferWidget(data){
  if(data == null){
    return LoadingAnimation();
  }
  if(data.isEmpty){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Er ging iets fout bij het ophalen van je cijfers. Als je hier wel cijfers zou moeten hebben, geef het dan aan op de feedback pagina.',
      ),
    );
  }
  if(data[0]['data'] == false){
    return LoadingAnimation();
  }
  return CijferList(data);
}

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
          case ConnectionState.active: return chooseCijferWidget(snapshot.data);
          case ConnectionState.done: return chooseCijferWidget(snapshot.data);
        }
      },
    );
  }
}