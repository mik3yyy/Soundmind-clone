class Booking {
  final int id;
  final int physicianId;
  final int patientId;
  final String date;
  final double amount;

  Booking({
    required this.id,
    required this.physicianId,
    required this.patientId,
    required this.date,
    required this.amount,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      physicianId: json['physicianId'],
      patientId: json['patientId'],
      date: json['date'],
      amount: json['amount'],
    );
  }
}
