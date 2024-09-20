import 'package:sound_mind/features/appointment/data/models/booking.dart';

class AppointmentDto {
  final Booking booking;
  final String therapistName;
  final String? profilePicture;
  final String? areaOfSpecialization;

  AppointmentDto({
    required this.booking,
    required this.therapistName,
    this.profilePicture,
    this.areaOfSpecialization,
  });

  factory AppointmentDto.fromJson(Map<String, dynamic> json) {
    return AppointmentDto(
      booking: Booking.fromJson(json['booking']),
      therapistName: json['therapistName'],
      profilePicture: json['profilePicture'],
      areaOfSpecialization: json['areaOfSpecialization'],
    );
  }
}
