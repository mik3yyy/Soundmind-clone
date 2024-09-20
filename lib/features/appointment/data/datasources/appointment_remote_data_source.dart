import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/features/Appointment/data/models/appointment_model.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentDto> getUpcomingAppointment();
  Future<List<Booking>> getAcceptedAppointments();
  Future<List<Booking>> getPendingAppointments();
  Future<List<Booking>> getRejectedAppointments();
  Future<void> createBooking(CreateBookingRequest request);
  Future<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request);
}

class AppointmentRemoteDataSourceImpl extends AppointmentRemoteDataSource {
  final Network _network;

  AppointmentRemoteDataSourceImpl({required Network network})
      : _network = network;

  @override
  Future<AppointmentDto> getUpcomingAppointment() async {
    final response = await _network.call(
      "/api/UserDashboard/GetUpcomingAppointment",
      RequestMethod.get,
    );
    return AppointmentDto.fromJson(response.data['data']);
  }

  @override
  Future<List<Booking>> getAcceptedAppointments() async {
    final response = await _network.call(
      "/api/UserDashboard/GetAcceptedAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
  }

  @override
  Future<List<Booking>> getPendingAppointments() async {
    final response = await _network.call(
      "/api/UserDashboard/GetPendingAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
  }

  @override
  Future<List<Booking>> getRejectedAppointments() async {
    final response = await _network.call(
      "/api/UserDashboard/GetRejectedAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
  }

  @override
  Future<void> createBooking(CreateBookingRequest request) async {
    await _network.call(
      "/api/UserDashboard/CreateBooking",
      RequestMethod.post,
      data: json.encode(request.toJson()),
    );
  }

  @override
  Future<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request) async {
    await _network.call(
      "/api/UserDashboard/BookingPayment",
      RequestMethod.post,
      data: json.encode(request.toJson()),
    );
  }
}
