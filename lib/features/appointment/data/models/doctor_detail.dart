class DoctorDetailModel {
  final int physicianId;
  final int userId;
  final String profilePicture;
  final String firstName;
  final String lastName;
  final int yoe; // Years of Experience
  final double consultationRate;
  final double ratingAverage;
  final AreaOfSpecializationModel areaOfSpecialization;
  final int ratingTotal;
  final int patientTotal;
  final String bio;
  final DateTime earliestAvailabiltyDate;
  final EarliestAvailabilityScheduleModel earliestAvailabilitySchedule;

  DoctorDetailModel({
    required this.physicianId,
    required this.userId,
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.yoe,
    required this.consultationRate,
    required this.ratingAverage,
    required this.areaOfSpecialization,
    required this.ratingTotal,
    required this.patientTotal,
    required this.bio,
    required this.earliestAvailabiltyDate,
    required this.earliestAvailabilitySchedule,
  });

  factory DoctorDetailModel.fromMap(Map<String, dynamic> map) {
    return DoctorDetailModel(
      physicianId: map['physicianId'],
      userId: map['userId'],
      profilePicture: map['profilePicture'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      yoe: map['yoe'],
      consultationRate: double.parse(map['consultationRate'].toString()),
      ratingAverage: double.parse(map['ratingAverage'].toString()),
      areaOfSpecialization:
          AreaOfSpecializationModel.fromMap(map['areaOfSpecialization']),
      ratingTotal: map['ratingTotal'],
      patientTotal: map['patientTotal'],
      bio: map['bio'],
      earliestAvailabiltyDate: DateTime.parse(map['earliestAvailabiltyDate']),
      earliestAvailabilitySchedule: EarliestAvailabilityScheduleModel.fromMap(
          map['earliestAvailabilitySchedule']),
    );
  }
}

class AreaOfSpecializationModel {
  final int id;
  final String name;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  AreaOfSpecializationModel({
    required this.id,
    required this.name,
    required this.timeCreated,
    required this.timeUpdated,
  });

  factory AreaOfSpecializationModel.fromMap(Map<String, dynamic> map) {
    return AreaOfSpecializationModel(
      id: map['id'],
      name: map['name'],
      timeCreated: DateTime.parse(map['timeCreated']),
      timeUpdated: DateTime.parse(map['timeUpdated']),
    );
  }
}

class EarliestAvailabilityScheduleModel {
  final int id;
  final int physicianId;
  final int userId;
  final int dayOfWeek;
  final bool isTaken;
  final String dayOfWeekTitle;
  final String startTime;
  final String endTime;

  EarliestAvailabilityScheduleModel({
    required this.id,
    required this.physicianId,
    required this.userId,
    required this.dayOfWeek,
    required this.isTaken,
    required this.dayOfWeekTitle,
    required this.startTime,
    required this.endTime,
  });

  factory EarliestAvailabilityScheduleModel.fromMap(Map<String, dynamic> map) {
    return EarliestAvailabilityScheduleModel(
      id: map['id'],
      physicianId: map['physicianId'],
      userId: map['userId'],
      dayOfWeek: map['dayOfWeek'],
      isTaken: map['isTaken'],
      dayOfWeekTitle: map['dayOfWeekTitle'],
      startTime: map['startTime'],
      endTime: map['endTime'],
    );
  }
}
