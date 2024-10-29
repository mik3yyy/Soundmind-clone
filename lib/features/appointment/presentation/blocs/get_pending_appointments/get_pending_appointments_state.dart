part of 'get_pending_appointments_cubit.dart';

abstract class PendingAppointmentsState extends Equatable {
  const PendingAppointmentsState();

  @override
  List<Object> get props => [];
}

class PendingAppointmentsInitial extends PendingAppointmentsState {}

class PendingAppointmentsLoading extends PendingAppointmentsState {}

class PendingAppointmentsLoaded extends PendingAppointmentsState {
  final List<AppointmentDto> appointments;

  const PendingAppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class PendingAppointmentsError extends PendingAppointmentsState {
  final String message;

  const PendingAppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}
