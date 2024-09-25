part of 'upcoming_appointment_cubit.dart';

sealed class UpcomingAppointmentState extends Equatable {
  const UpcomingAppointmentState();

  @override
  List<Object> get props => [];
}

class UpcomingAppointmentInitial extends UpcomingAppointmentState {}

class UpcomingAppointmentLoading extends UpcomingAppointmentState {}

class UpcomingAppointmentsLoaded extends UpcomingAppointmentState {
  final AppointmentDto upcomingAppointments;

  const UpcomingAppointmentsLoaded({required this.upcomingAppointments});

  @override
  List<Object> get props => [upcomingAppointments];
}

class UpcomingAppointmentError extends UpcomingAppointmentState {
  final String message;

  UpcomingAppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}
