import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/physician_schedule.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_physician_schedule.dart';

part 'physician_schedule_state.dart';

class PhysicianScheduleCubit extends Cubit<PhysicianScheduleState> {
  final GetPhysicianScheduleUseCase getPhysicianScheduleUseCase;

  PhysicianScheduleCubit({required this.getPhysicianScheduleUseCase})
      : super(PhysicianScheduleInitial());

  Future<void> fetchPhysicianSchedule(int physicianId) async {
    emit(PhysicianScheduleLoading());

    final result = await getPhysicianScheduleUseCase
        .call(GetPhysicianScheduleParams(physicianId: physicianId));

    result.fold(
      (failure) => emit(PhysicianScheduleError(message: failure.message)),
      (schedules) => emit(PhysicianScheduleLoaded(schedules: schedules)),
    );
  }
}
