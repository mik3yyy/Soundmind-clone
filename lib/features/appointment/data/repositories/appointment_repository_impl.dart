import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/exceptions.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:sound_mind/features/appointment/data/datasources/appointment_hive_data_source.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  final AppointmentRemoteDataSource _remoteDataSource;
  final AppointmentHiveDataSource _appointmentHiveDataSource;

  AppointmentRepositoryImpl(
      {required AppointmentRemoteDataSource remoteDataSource,
      required AppointmentHiveDataSource appointmentHiveDataSource})
      : _remoteDataSource = remoteDataSource,
        _appointmentHiveDataSource = appointmentHiveDataSource;

  @override
  ResultFuture<List<DoctorModel>> getDoctors(
      {required int pageNumber, required int pageSize}) async {
    try {
      // final doctors = await _remoteDataSource.getDoctors(
      //     pageNumber: pageNumber, pageSize: pageSize);//it returns a List on Map<String, dynamic>

      final doctorsList = await _remoteDataSource.getDoctors(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );

      // Map each doctor from Map<String, dynamic> to DoctorModel
      final doctors = doctorsList.map((doctorMap) {
        return DoctorModel.fromMap(doctorMap);
      }).toList();
      return Right(doctors);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(e.message),
      );
    }
  }

  @override
  ResultFuture<AppointmentDto> getUpcomingAppointment() async {
    try {
      final appointment = await _remoteDataSource.getUpcomingAppointment();
      return Right(appointment);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<AppointmentDto>> getAcceptedAppointments() async {
    try {
      final appointments = await _remoteDataSource.getAcceptedAppointments();
      return Right(appointments);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch accepted appointments"));
    }
  }

  @override
  ResultFuture<List<AppointmentDto>> getPendingAppointments() async {
    // try {
    final appointments = await _remoteDataSource.getPendingAppointments();
    return Right(appointments);
    // } catch (error) {
    //   print(error);
    //   return const Left(ServerFailure("Failed to fetch pending appointments"));
    // }
  }

  @override
  ResultFuture<List<AppointmentDto>> getRejectedAppointments() async {
    try {
      final appointments = await _remoteDataSource.getRejectedAppointments();
      return Right(appointments);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch rejected appointments"));
    }
  }

  @override
  ResultFuture<void> createBooking(CreateBookingRequest request) async {
    try {
      await _remoteDataSource.createBooking(request);
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request) async {
    try {
      await _remoteDataSource.makePaymentForAppointment(request);
      return const Right(null);
    } catch (error) {
      return const Left(
          ServerFailure("Failed to make payment for appointment"));
    }
  }

  @override
  ResultFuture<DoctorDetailModel> getDoctorDetails(
      {required int physicianId}) async {
    try {
      final doctorDetail =
          await _remoteDataSource.getDoctorDetails(physicianId);
      return Right(doctorDetail);
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure('Failed to fetch doctor details.'));
    }
  }

  @override
  ResultFuture<List<PhysicianScheduleModel>> getPhysicianSchedule(
      {required int physicianId}) async {
    try {
      final scheduleList =
          await _remoteDataSource.getPhysicianSchedule(physicianId);
      return Right(scheduleList);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch physician schedule.'));
    }
  }
}
