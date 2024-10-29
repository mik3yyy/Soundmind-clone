part of 'get_accepted_appointments_cubit.dart';

abstract class AcceptedAppointmentsState extends Equatable {
  const AcceptedAppointmentsState();

  @override
  List<Object> get props => [];
}

class AcceptedAppointmentsInitial extends AcceptedAppointmentsState {}

class AcceptedAppointmentsLoading extends AcceptedAppointmentsState {}

class AcceptedAppointmentsLoaded extends AcceptedAppointmentsState {
  final List<AppointmentDto> appointments;

  const AcceptedAppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AcceptedAppointmentsError extends AcceptedAppointmentsState {
  final String message;

  const AcceptedAppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}
