import 'package:flutter/material.dart';
import '../models/cijfer_data_model.dart';
import '../functions/get_cijfers.dart';

CijferDataModel cijferDataModel = CijferDataModel();

class CijferRefreshWrapper extends StatelessWidget {

  final Widget cijferStreamBuilder;
  final int period;
  CijferRefreshWrapper(this.cijferStreamBuilder, this.period);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: cijferStreamBuilder,
      onRefresh: () async {
        await addCijfersFromServerToControllerAndCache(cijferDataModel.getStreamController(period), period, isFromRefresh: true);
      },
    );
  }
}