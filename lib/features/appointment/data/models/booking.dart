class Booking {
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final int physicianId;
  final int physicianUserId;
  final int patientId;
  final int scheduleId;
  final DateTime date;
  final int status;
  final int paymentStatus;
  final double amount;
  final String? notes;
  final String? link;
  final String? transactionReference;
  final String? code;

  Booking({
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
    required this.physicianId,
    required this.physicianUserId,
    required this.patientId,
    required this.scheduleId,
    required this.date,
    required this.status,
    required this.paymentStatus,
    required this.amount,
    this.notes,
    this.link,
    this.transactionReference,
    this.code,
  });

  // Factory constructor to create a Booking from a JSON object
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
      physicianId: json['physicianId'],
      physicianUserId: json['physicianUserID'],
      patientId: json['patientId'],
      scheduleId: json['scheduleId'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      amount: (json['amount'] as num).toDouble(),
      notes: json['notes'],
      link: json['link'],
      transactionReference: json['transactionReference'],
      code: json['code'],
    );
  }

  // Method to convert Booking to JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
      'physicianId': physicianId,
      'physicianUserID': physicianUserId,
      'patientId': patientId,
      'scheduleId': scheduleId,
      'date': date.toIso8601String(),
      'status': status,
      'paymentStatus': paymentStatus,
      'amount': amount,
      'notes': notes,
      'link': link,
      'transactionReference': transactionReference,
      'code': code,
    };
  }
}
