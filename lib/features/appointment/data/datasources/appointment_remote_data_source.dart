import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sound_mind/core/error/exceptions.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/features/Appointment/data/models/appointment_model.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentDto> getUpcomingAppointment();
  Future<List<Booking>> getAcceptedAppointments();
  Future<List<Booking>> getPendingAppointments();
  Future<List<Booking>> getRejectedAppointments();
  Future<void> createBooking(CreateBookingRequest request);
  Future<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request);
  Future<List<Map<String, dynamic>>> getDoctors(
      {required int pageNumber, required int pageSize});
  Future<DoctorDetailModel> getDoctorDetails(int physicianId);
  Future<List<PhysicianScheduleModel>> getPhysicianSchedule(int physicianId);
}

class AppointmentRemoteDataSourceImpl extends AppointmentRemoteDataSource {
  final Network _network;

  AppointmentRemoteDataSourceImpl({required Network network})
      : _network = network;

  @override
  Future<List<Map<String, dynamic>>> getDoctors(
      {required int pageNumber, required int pageSize}) async {
    try {
      final response = await _network.call(
        "/UserDashboard/GetDoctors",
        RequestMethod.get,
        queryParams: {
          "PageNumber": pageNumber,
          "PageSize": pageSize,
        },
      );
      return (response.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: "Error");
    }
  }

  @override
  Future<AppointmentDto> getUpcomingAppointment() async {
    final response = await _network.call(
      "/UserDashboard/GetUpcomingAppointment",
      RequestMethod.get,
    );
    print(response.data);
    return AppointmentDto.fromJson(response.data['data']);
  }

  @override
  Future<List<Booking>> getAcceptedAppointments() async {
    final response = await _network.call(
      "/UserDashboard/GetAcceptedAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
  }

  @override
  Future<List<Booking>> getPendingAppointments() async {
    final response = await _network.call(
      "/UserDashboard/GetPendingAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
  }

  @override
  Future<List<Booking>> getRejectedAppointments() async {
    final response = await _network.call(
      "/UserDashboard/GetRejectedAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => Booking.fromJson(booking))
        .toList();
  }

  @override
  Future<void> createBooking(CreateBookingRequest request) async {
    await _network.call(
      "/UserDashboard/CreateBooking",
      RequestMethod.post,
      data: json.encode(request.toJson()),
    );
  }

  @override
  Future<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request) async {
    await _network.call(
      "/UserDashboard/BookingPayment",
      RequestMethod.post,
      data: json.encode(request.toJson()),
    );
  }

  @override
  Future<DoctorDetailModel> getDoctorDetails(int physicianId) async {
    final response = await _network.call(
      "/UserDashboard/GetDoctorsDetails",
      RequestMethod.get,
      queryParams: {"PhysicianID": physicianId},
    );

    // Check for error response and throw exception
    if (response.statusCode != 200) {
      throw ServerException(
          message: response
              .statusMessage!); // You can customize this based on the response
    }

    return DoctorDetailModel.fromMap(response.data['data']);
  }

  @override
  Future<List<PhysicianScheduleModel>> getPhysicianSchedule(
      int physicianId) async {
    final response = await _network.call(
      "/UserDashboard/GetPhysicianSchedule",
      RequestMethod.get,
      queryParams: {"PhysicianID": physicianId},
    );

    if (response.statusCode != 200) {
      throw ServerException(message: '');
    }

    return (response.data['data'] as List)
        .map((e) => PhysicianScheduleModel.fromMap(e))
        .toList();
  }
}
