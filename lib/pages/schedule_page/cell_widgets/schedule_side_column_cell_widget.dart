import 'package:flutter/material.dart';

class ScheduleSideColumnCell extends StatelessWidget {

  final int index;
  ScheduleSideColumnCell(this.index);

  @override
  Widget build(BuildContext context) {
    bool rowIsOdd = ((index / 6) % 2 == 1);
    return Container(
      //color: rowIsOdd ? Colors.blue[200] : Colors.blue[300],
      color: rowIsOdd
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).primaryColorDark,
      child: Center(
        child: Text((index ~/ 6 + 1).toString(),
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.white70)),
      ),
    );
  }
}
