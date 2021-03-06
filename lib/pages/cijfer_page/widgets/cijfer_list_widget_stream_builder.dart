import 'package:flutter/material.dart';
import 'dart:async';

import '../../../widgets/loading_animation.dart';
import 'cijfer_list_widget.dart';

import '../functions/get_cijfers.dart';

import '../models/cijfer_data_model.dart';

CijferDataModel cijferDataModel = CijferDataModel();

Widget chooseCijferWidget(data, period){
  if(data == null || data.isEmpty){
    cijferDataModel.periodsLoadedThisRun.remove(period);
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
  //return Text(period.toString());
  return CijferList(data);
}

class CijferListStreamBuilder extends StatefulWidget {
  final int period;
  CijferListStreamBuilder(this.period);

  @override
  _CijferListStreamBuilderState createState() => _CijferListStreamBuilderState();
}

class _CijferListStreamBuilderState extends State<CijferListStreamBuilder> with AutomaticKeepAliveClientMixin, GetCijfers{
  
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    cijferStreamController = StreamController();
    super.initState();
  }

  @override
  void dispose() {
    cijferStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cijferDataModel.setStreamController(widget.period, cijferStreamController);
    getCijfers(widget.period);

    return StreamBuilder(
      stream: cijferStreamController.stream,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none: return LoadingAnimation();
          case ConnectionState.waiting: return LoadingAnimation();
          case ConnectionState.active: return chooseCijferWidget(snapshot.data, widget.period);
          case ConnectionState.done: return chooseCijferWidget(snapshot.data, widget.period);
        }
      },
    );
  }
}