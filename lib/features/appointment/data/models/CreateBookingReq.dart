class CreateBookingRequest {
  final int physicianID;
  final int scheduleID;

  CreateBookingRequest({
    required this.physicianID,
    required this.scheduleID,
  });

  Map<String, dynamic> toJson() {
    return {
      "physicianID": physicianID,
      "scheduleID": scheduleID,
    };
  }
}
