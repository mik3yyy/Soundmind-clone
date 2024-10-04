import 'package:equatable/equatable.dart';

class NotificationModel {
  final int id;
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final int userId;
  final int type;
  final int bookingId;
  final int senderId;
  final String message;

  NotificationModel({
    required this.id,
    required this.timeCreated,
    required this.timeUpdated,
    required this.userId,
    required this.type,
    required this.bookingId,
    required this.senderId,
    required this.message,
  });

  // Factory method to create a NotificationModel object from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      timeCreated: DateTime.parse(json['timeCreated']),
      timeUpdated: DateTime.parse(json['timeUpdated']),
      userId: json['userId'],
      type: json['type'],
      bookingId: json['bookingId'],
      senderId: json['senderId'],
      message: json['message'],
    );
  }

  // Method to convert a NotificationModel object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timeCreated': timeCreated.toIso8601String(),
      'timeUpdated': timeUpdated.toIso8601String(),
      'userId': userId,
      'type': type,
      'bookingId': bookingId,
      'senderId': senderId,
      'message': message,
    };
  }
}
