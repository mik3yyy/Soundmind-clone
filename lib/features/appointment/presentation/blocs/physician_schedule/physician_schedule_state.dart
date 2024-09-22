part of 'physician_schedule_cubit.dart';

abstract class PhysicianScheduleState extends Equatable {
  const PhysicianScheduleState();

  @override
  List<Object?> get props => [];
}

class PhysicianScheduleInitial extends PhysicianScheduleState {}

class PhysicianScheduleLoading extends PhysicianScheduleState {}

class PhysicianScheduleLoaded extends PhysicianScheduleState {
  final List<PhysicianScheduleModel> schedules;

  const PhysicianScheduleLoaded({required this.schedules});

  @override
  List<Object?> get props => [schedules];
}

class PhysicianScheduleError extends PhysicianScheduleState {
  final String message;

  const PhysicianScheduleError({required this.message});

  @override
  List<Object?> get props => [message];
}
