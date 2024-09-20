import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Appointment/data/datasources/appointment_remote_data_source.dart';
import 'package:sound_mind/features/Appointment/domain/repositories/appointment_repository.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';

class AppointmentRepositoryImpl extends AppointmentRepository {
  final AppointmentRemoteDataSource _remoteDataSource;

  AppointmentRepositoryImpl(
      {required AppointmentRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  ResultFuture<AppointmentDto> getUpcomingAppointment() async {
    try {
      final appointment = await _remoteDataSource.getUpcomingAppointment();
      return Right(appointment);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch upcoming appointments"));
    }
  }

  @override
  ResultFuture<List<Booking>> getAcceptedAppointments() async {
    try {
      final appointments = await _remoteDataSource.getAcceptedAppointments();
      return Right(appointments);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch accepted appointments"));
    }
  }

  @override
  ResultFuture<List<Booking>> getPendingAppointments() async {
    try {
      final appointments = await _remoteDataSource.getPendingAppointments();
      return Right(appointments);
    } catch (error) {
      return const Left(ServerFailure("Failed to fetch pending appointments"));
    }
  }

  @override
  ResultFuture<List<Booking>> getRejectedAppointments() async {
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
    } catch (error) {
      return const Left(ServerFailure("Failed to create booking"));
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
}
