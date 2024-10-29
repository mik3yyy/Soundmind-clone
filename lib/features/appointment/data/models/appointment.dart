import 'package:sound_mind/features/appointment/data/models/booking.dart';

class AppointmentDto {
  final Booking booking;
  final String therapistName;
  final String? profilePicture;
  final String? areaOfSpecialization;
  final Schedule schedule;

  AppointmentDto({
    required this.booking,
    required this.therapistName,
    required this.schedule,
    this.profilePicture,
    this.areaOfSpecialization,
  });

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    return AppointmentDto(
      booking: Booking.fromJson(json['booking']),
      therapistName: json['therapistName'] ?? json['patientName'],
      profilePicture: json['profilePicture'],
      areaOfSpecialization: json['areaOfSpecialization'],
      schedule: Schedule.fromJson(json['schedule']),
    );
  }
}

class Schedule {
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final int physicianId;
  final int userId;
  final int dayOfWeek;
  final bool isTaken;
  final String dayOfWeekTitle;
  final String startTime;
  final String endTime;

  Schedule({
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
    required this.physicianId,
    required this.userId,
    required this.dayOfWeek,
    required this.isTaken,
    required this.dayOfWeekTitle,
    required this.startTime,
    required this.endTime,
  });

  // Factory constructor to create a Schedule from a JSON object
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
      physicianId: json['physicianId'],
      userId: json['userId'],
      dayOfWeek: json['dayOfWeek'],
      isTaken: json['isTaken'],
      dayOfWeekTitle: json['dayOfWeekTitle'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  // Method to convert Schedule to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
      'physicianId': physicianId,
      'userId': userId,
      'dayOfWeek': dayOfWeek,
      'isTaken': isTaken,
      'dayOfWeekTitle': dayOfWeekTitle,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
