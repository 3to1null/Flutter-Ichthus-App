import 'package:flutter/material.dart';

/// Represents the data of a Model, can be initialized with fromJson() to transform an appointment 
/// JSON object to an AppointmentModel.
class Appointment {
  final int appointmentInstance;
  final int id;
  final String uniqueId;
  final List<String> subjects;
  final List<String> locations;
  final List<String> teachers;
  final List<String> teachersFullnames;
  final List<String> groups;
  final int start;
  final int end;
  final int renderStart;
  final int renderEnd;
  final bool moved;
  final bool isNew;
  final bool cancelled;
  final bool exists;
  final String type;
  final String extraMessage;

  Color color;

  /// Uses the map from the schedule list to initialize the AppointmentModel.
  Appointment.fromJson(Map<String, dynamic> json)
    : appointmentInstance = json["appointmentInstance"] ?? 0,
      id = json["id"] ?? 0,
      uniqueId = "${json["appointmentInstance"].toString()}_${json["id"]}",
      subjects = List<String>.from(json["subjects"] ?? []),
      locations = List<String>.from(json["locations"] ?? []),
      teachers = List<String>.from(json["teachers"] ?? []),
      teachersFullnames = List<String>.from(json["teachers_full"] ?? []),
      groups = List<String>.from(json["groups"] ?? []),
      start = json["start"] ?? 0,
      end = json["end"] ?? 0,
      renderStart = json["_r_start"] ?? 0,
      renderEnd = json["_r_end"] ?? 0,
      moved = (json["moved"] ?? false) == true,
      isNew = (json["new"] ?? false) == true,
      cancelled = (json["cancelled"] ?? false) == true,
      exists = json["exists"] == false ? false : true,
      type = json["type"] ?? "",
      extraMessage = json["changeDescription"] ?? json["remark"] ?? "";
}
