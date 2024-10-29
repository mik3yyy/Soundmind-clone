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
  Future<List<AppointmentDto>> getAcceptedAppointments();
  Future<List<AppointmentDto>> getPendingAppointments();
  Future<List<AppointmentDto>> getRejectedAppointments();
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
  static String dummyJsonResponse = '''
{
  "booking": {
    "physicianId": 9,
    "physicianUserID": 32,
    "patientId": 31,
    "scheduleId": 139,
    "date": "2024-10-07",
    "status": 2,
    "paymentStatus": 2,
    "amount": 12000,
    "notes": "",
    "link": "",
    "transactionReference": "cc068f10-c5b6-48ec-8f97-255fcccad9a9",
    "code": "50WNcn",
    "id": 7,
    "timeCreated": "2024-10-05T17:11:04.509549+00:00",
    "timeUpdated": "2024-10-05T17:11:04.509549+00:00"
  },
  "schedule": {
    "physicianId": 9,
    "userId": 32,
    "dayOfWeek": 1,
    "isTaken": true,
    "dayOfWeekTitle": "Monday",
    "startTime": "10:00:00",
    "endTime": "11:00:00",
    "id": 139,
    "timeCreated": "2024-10-05T13:49:39.529582+00:00",
    "timeUpdated": "2024-10-05T13:49:39.529582+00:00"
  },
  "therapistName": "Okpechi Michael",
  "profilePicture": "https://res.cloudinary.com/dwwzrtzb8/image/upload/v1723891089/Therapist/degree.png",
  "areaOfSpecialization": "Dialectical Behavior Therapy (DBT)"
}
''';

  List appointments = [dummyJsonResponse];
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
  Future<List<AppointmentDto>> getAcceptedAppointments() async {
    final response = await _network.call(
      "/UserDashboard/GetAcceptedAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => AppointmentDto.fromJson(booking))
        .toList();
  }

  @override
  Future<List<AppointmentDto>> getPendingAppointments() async {
    final response = await _network.call(
      "/UserDashboard/GetPendingAppointments",
      RequestMethod.get,
    );

    print((response.data['data'] as List)
        .map((booking) =>
            AppointmentDto.fromJson(booking as Map<String, dynamic>))
        .toList());
    return (response.data['data'] as List)
        .map((booking) =>
            AppointmentDto.fromJson(booking as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AppointmentDto>> getRejectedAppointments() async {
    final response = await _network.call(
      "/UserDashboard/GetRejectedAppointments",
      RequestMethod.get,
    );
    return (response.data['data'] as List)
        .map((booking) => AppointmentDto.fromJson(booking))
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
