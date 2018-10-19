import 'package:flutter/material.dart';

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
        return Text(snapshot.toString());
      },
    );
  }
}