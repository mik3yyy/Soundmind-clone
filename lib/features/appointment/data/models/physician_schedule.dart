class PhysicianScheduleModel {
  final int id;
  final int physicianId;
  final int userId;
  final int dayOfWeek; // Represents day of the week as an integer (0-6)
  final bool isTaken;
  final String dayOfWeekTitle; // Title for the day (e.g., Monday, Tuesday)
  final String startTime; // In a format like "08:00 AM"
  final String endTime; // In a format like "05:00 PM"
  final DateTime timeCreated;
  final DateTime timeUpdated;

  PhysicianScheduleModel({
    required this.id,
    required this.physicianId,
    required this.userId,
    required this.dayOfWeek,
    required this.isTaken,
    required this.dayOfWeekTitle,
    required this.startTime,
    required this.endTime,
    required this.timeCreated,
    required this.timeUpdated,
  });

  factory PhysicianScheduleModel.fromMap(Map<String, dynamic> map) {
    return PhysicianScheduleModel(
      id: map['id'],
      physicianId: map['physicianId'],
      userId: map['userId'],
      dayOfWeek: map['dayOfWeek'],
      isTaken: map['isTaken'],
      dayOfWeekTitle: map['dayOfWeekTitle'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      timeCreated: DateTime.parse(map['timeCreated']),
      timeUpdated: DateTime.parse(map['timeUpdated']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'physicianId': physicianId,
      'userId': userId,
      'dayOfWeek': dayOfWeek,
      'isTaken': isTaken,
      'dayOfWeekTitle': dayOfWeekTitle,
      'startTime': startTime,
      'endTime': endTime,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
    };
  }
}
