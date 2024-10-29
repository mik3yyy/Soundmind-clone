import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';

abstract class AppointmentRepository {
  ResultFuture<AppointmentDto> getUpcomingAppointment();
  ResultFuture<List<AppointmentDto>> getAcceptedAppointments();
  ResultFuture<List<AppointmentDto>> getPendingAppointments();
  ResultFuture<List<AppointmentDto>> getRejectedAppointments();
  ResultFuture<void> createBooking(CreateBookingRequest request);
  ResultFuture<void> makePaymentForAppointment(
      MakePaymentForAppointmentRequest request);
  ResultFuture<List<DoctorModel>> getDoctors(
      {required int pageNumber, required int pageSize});
  ResultFuture<DoctorDetailModel> getDoctorDetails({required int physicianId});
  ResultFuture<List<PhysicianScheduleModel>> getPhysicianSchedule(
      {required int physicianId});
}
