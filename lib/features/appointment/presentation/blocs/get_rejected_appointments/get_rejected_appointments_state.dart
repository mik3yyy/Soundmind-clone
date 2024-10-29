part of 'get_rejected_appointments_cubit.dart';

abstract class RejectedAppointmentsState extends Equatable {
  const RejectedAppointmentsState();

  @override
  List<Object> get props => [];
}

class RejectedAppointmentsInitial extends RejectedAppointmentsState {}

class RejectedAppointmentsLoading extends RejectedAppointmentsState {}

class RejectedAppointmentsLoaded extends RejectedAppointmentsState {
  final List<AppointmentDto> appointments;

  const RejectedAppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class RejectedAppointmentsError extends RejectedAppointmentsState {
  final String message;

  const RejectedAppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}
