part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

// Initial State
class AppointmentInitial extends AppointmentState {}

// Loading States
class AppointmentLoading extends AppointmentState {}

// Individual Loaded States for each appointment type
class UpcomingAppointmentsLoaded extends AppointmentState {
  final AppointmentDto upcomingAppointments;

  const UpcomingAppointmentsLoaded({required this.upcomingAppointments});

  @override
  List<Object?> get props => [upcomingAppointments];
}

class AcceptedAppointmentsLoaded extends AppointmentState {
  final List<Booking> acceptedAppointments;

  const AcceptedAppointmentsLoaded({required this.acceptedAppointments});

  @override
  List<Object?> get props => [acceptedAppointments];
}

class PendingAppointmentsLoaded extends AppointmentState {
  final List<Booking> pendingAppointments;

  const PendingAppointmentsLoaded({required this.pendingAppointments});

  @override
  List<Object?> get props => [pendingAppointments];
}

class RejectedAppointmentsLoaded extends AppointmentState {
  final List<Booking> rejectedAppointments;

  const RejectedAppointmentsLoaded({required this.rejectedAppointments});

  @override
  List<Object?> get props => [rejectedAppointments];
}

// Error States
class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError({required this.message});

  @override
  List<Object?> get props => [message];
}
