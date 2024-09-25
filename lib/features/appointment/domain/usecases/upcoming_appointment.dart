import 'package:sound_mind/core/utils/typedef.dart';
// import 'package:sound_mind/features/Appointment/domain/repositories/Appointment_repository.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';

import '../../../appointment/domain/repositories/appointment_repository.dart';

class GetUpcomingAppointments extends UsecaseWithoutParams<AppointmentDto> {
  final AppointmentRepository repository;

  GetUpcomingAppointments({required this.repository});
  // : _repository = repository;

  @override
  ResultFuture<AppointmentDto> call() => repository.getUpcomingAppointment();
}
