import 'package:flutter/material.dart';
import '../../functions/hex_to_color.dart';

import 'models/appointment.dart';

Color appointmentBackgroundColor(Appointment appointment, int index) {
  if (appointment.exists == false) {
    return hexToColor("b3b3b3");
  } else {
    if (appointment.cancelled) {
      return hexToColor("e53935");
    } else if (appointment.moved || appointment.isNew) {
      return hexToColor("f57f17");
    } else if (appointment.type== "exam") {
      return hexToColor("DCE775");
    } else {
      return hexToColor("6ea7bc");
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
