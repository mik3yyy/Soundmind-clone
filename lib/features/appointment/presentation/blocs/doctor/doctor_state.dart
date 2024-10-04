part of 'doctor_cubit.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

enum Sort { a_z, z_a, Rl_h, Rh_l, Ph_l, Pl_h, most_experienced }

enum Display { grid, list }

class DoctorLoaded extends DoctorState {
  final List<DoctorModel> doctors;
  final Sort? sort;
  final Display display;

  const DoctorLoaded(
      {required this.doctors, this.sort, this.display = Display.list});

  @override
  List<Object?> get props => [doctors, sort, display];
}

class DoctorError extends DoctorState {
  final String message;

  const DoctorError({required this.message});

  @override
  List<Object?> get props => [message];
}
