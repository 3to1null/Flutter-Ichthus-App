import 'package:flutter/material.dart';

Color circleColor(dynamic mark) {
  if (mark == '-' || mark == '*' || mark == 'V' || mark == 'G') {
    return Colors.green;
  } else if (mark == 'O') {
    return Colors.red;
  } else {
    try{
      num parsedMark = num.parse(mark);
      if (parsedMark >= 5.5) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }catch(FormatException){
      return Colors.green;
    }
  }
}
