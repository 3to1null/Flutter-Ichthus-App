import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation extends StatelessWidget {
  double size;

  LoadingAnimation([this.size=50.0]);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitWanderingCubes(color: Theme.of(context).accentColor, size: size,),
      )
    );
  }
}
