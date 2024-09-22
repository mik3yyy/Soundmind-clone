class DoctorModel {
  final int physicianId;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final int yoe;
  final double consultationRate;
  final double ratingAverage;

  DoctorModel({
    required this.physicianId,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.yoe,
    required this.consultationRate,
    required this.ratingAverage,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      physicianId: map['physicianId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      profilePicture: map['profilePicture'],
      yoe: map['yoe'],
      consultationRate: double.parse(map['consultationRate'].toString()),
      ratingAverage: double.parse(map['ratingAverage'].toString()),
    );
  }
}
