import 'package:flutter/material.dart';
import '../../functions/hex_to_color.dart';

import 'models/appointment.dart';

Color appointmentBackgroundColor(Appointment appointment, int index) {
  bool rowIsOdd = false;
  if (index < 5 ||
      (index >= 10 && index < 15) ||
      (index >= 20 && index < 25) ||
      (index >= 30 && index < 35) ||
      (index >= 40 && index < 45)) {
    rowIsOdd = true;
  }
  if (appointment.exists == false) {
    return rowIsOdd ? hexToColor("b3b3b3") : hexToColor("cccccc");
  } else {
    if (appointment.cancelled) {
      return rowIsOdd ? hexToColor("ff0000") : hexToColor("ff3333");
    } else if (appointment.moved) {
      return rowIsOdd ? hexToColor("ff9900") : hexToColor("ffad33");
    } else if (appointment.type== "exam") {
      return rowIsOdd ? hexToColor("DCE775") : hexToColor("CDDC39");
    } else {
      return rowIsOdd ? hexToColor("ccccff") : hexToColor("e6e6ff");
    }
  }
}

int getRealIndex(fakeIndex) {
  if (fakeIndex <= 6) {
    return fakeIndex - 1;
  } else if (fakeIndex <= 12) {
    return fakeIndex - 2;
  } else if (fakeIndex <= 18) {
    return fakeIndex - 3;
  } else if (fakeIndex <= 24) {
    return fakeIndex - 4;
  } else if (fakeIndex <= 30) {
    return fakeIndex - 5;
  } else if (fakeIndex <= 36) {
    return fakeIndex - 6;
  } else if (fakeIndex <= 42) {
    return fakeIndex - 7;
  } else if (fakeIndex <= 48) {
    return fakeIndex - 8;
  } else if (fakeIndex <= 54) {
    return fakeIndex - 9;
  }
  return 0;
}
