import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class GetPhysicianScheduleUseCase extends UsecaseWithParams<
    List<PhysicianScheduleModel>, GetPhysicianScheduleParams> {
  final AppointmentRepository repository;

  GetPhysicianScheduleUseCase({required this.repository});

  @override
  ResultFuture<List<PhysicianScheduleModel>> call(
      GetPhysicianScheduleParams params) {
    return repository.getPhysicianSchedule(physicianId: params.physicianId);
  }
}

class GetPhysicianScheduleParams {
  final int physicianId;

  GetPhysicianScheduleParams({required this.physicianId});
}
