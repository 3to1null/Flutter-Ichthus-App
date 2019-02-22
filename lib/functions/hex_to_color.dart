import 'package:flutter/material.dart';
import 'hex_to_int.dart';

/// Converts the [hexCode] to a flutter Color.
Color hexToColor(String hexCode) {
  if (hexCode.startsWith("#")) {
    hexCode.substring(1);
  }
  if (hexCode.length == 6) {
    hexCode = "FF" + hexCode;
  }
  return Color(hexToInt(hexCode));
}
