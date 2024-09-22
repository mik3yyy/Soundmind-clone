part of 'doctor_details_cubit.dart';

abstract class DoctorDetailsState extends Equatable {
  const DoctorDetailsState();

  @override
  List<Object?> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsState {}

class DoctorDetailsLoading extends DoctorDetailsState {}

class DoctorDetailsLoaded extends DoctorDetailsState {
  final DoctorDetailModel doctor;

  const DoctorDetailsLoaded({required this.doctor});

  @override
  List<Object?> get props => [doctor];
}

class DoctorDetailsError extends DoctorDetailsState {
  final String message;

  const DoctorDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
