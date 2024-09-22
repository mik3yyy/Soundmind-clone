import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Appointment/data/models/appointment_model.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class GetPendingAppointments extends UsecaseWithoutParams<List<Booking>> {
  final AppointmentRepository _repository;

  GetPendingAppointments({required AppointmentRepository repository})
      : _repository = repository;

  @override
  ResultFuture<List<Booking>> call() => _repository.getPendingAppointments();
}