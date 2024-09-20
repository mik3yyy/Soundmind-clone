class MakePaymentForAppointmentRequest {
  final int bookingID;

  MakePaymentForAppointmentRequest({
    required this.bookingID,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookingID": bookingID,
    };
  }
}
