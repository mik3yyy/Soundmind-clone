import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';

abstract class AppointmentRepository {
  ResultFuture<AppointmentDto> getUpcomingAppointment();
  ResultFuture<List<Booking>> getAcceptedAppointments();
  ResultFuture<List<Booking>> getPendingAppointments();
  ResultFuture<List<Booking>> getRejectedAppointments();
  ResultFuture<void> createBooking(CreateBookingRequest request);
  ResultFuture<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request);
}
