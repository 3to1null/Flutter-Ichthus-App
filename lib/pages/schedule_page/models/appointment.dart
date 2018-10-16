import 'package:flutter/material.dart';

/// Represents the data of a Model, can be initialized with fromJson() to transform an appointment 
/// JSON object to an AppointmentModel.
class Appointment {
  final int appointmentInstance;
  final List<String> subjects;
  final List<String> locations;
  final List<String> teachers;
  final List<String> groups;
  final bool moved;
  final bool cancelled;
  final bool exists;
  final String type;
  Color color;

  /// Uses the map from the schedule list to initialize the AppointmentModel.
  Appointment.fromJson(Map<String, dynamic> json)
    : appointmentInstance = json["appointmentInstance"] ?? 0,
      subjects = List<String>.from(json["subjects"] ?? []),
      locations = List<String>.from(json["locations"] ?? []),
      teachers = List<String>.from(json["teachers"] ?? []),
      groups = List<String>.from(json["groups"] ?? []),
      moved = (json["moved"] ?? false) == true,
      cancelled = (json["cancelled"] ?? false) == true,
      type = json["type"] ?? "",
      exists = json["exists"] == false ? false : true;


}
