part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class FetchUpcomingAppointmentsEvent extends AppointmentEvent {}

class FetchAcceptedAppointmentsEvent extends AppointmentEvent {}

class FetchPendingAppointmentsEvent extends AppointmentEvent {}

class FetchRejectedAppointmentsEvent extends AppointmentEvent {}
