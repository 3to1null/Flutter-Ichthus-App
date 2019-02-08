import 'package:flutter/material.dart';

Color circleColor(dynamic mark) {
  if (mark == '-' || mark == '*') {
    return Colors.green;
  } else {
    num parsedMark = num.parse(mark);
    if (parsedMark >= 5.5) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
