import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_accepted_appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_pending_appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/rejected_appointment.dart';
import 'package:sound_mind/features/appointment/domain/usecases/upcoming_appointment.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final GetUpcomingAppointments getUpcomingAppointments;
  final GetAcceptedAppointments getAcceptedAppointments;
  final GetPendingAppointments getPendingAppointments;
  final GetRejectedAppointments getRejectedAppointments;

  AppointmentBloc({
    required this.getUpcomingAppointments,
    required this.getAcceptedAppointments,
    required this.getPendingAppointments,
    required this.getRejectedAppointments,
  }) : super(AppointmentInitial()) {
    on<FetchUpcomingAppointmentsEvent>(_fetchUpcomingAppointments);
    on<FetchAcceptedAppointmentsEvent>(_fetchAcceptedAppointments);
    on<FetchPendingAppointmentsEvent>(_fetchPendingAppointments);
    on<FetchRejectedAppointmentsEvent>(_fetchRejectedAppointments);
  }

  Future<void> _fetchUpcomingAppointments(FetchUpcomingAppointmentsEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());

    final result = await getUpcomingAppointments.call();
    result.fold(
      (failure) => emit(AppointmentError(message: failure.message)),
      (appointments) =>
          emit(UpcomingAppointmentsLoaded(upcomingAppointments: appointments)),
    );
  }

  Future<void> _fetchAcceptedAppointments(FetchAcceptedAppointmentsEvent event,
      Emitter<AppointmentState> emit) async {}

  Future<void> _fetchPendingAppointments(FetchPendingAppointmentsEvent event,
      Emitter<AppointmentState> emit) async {}

  Future<void> _fetchRejectedAppointments(FetchRejectedAppointmentsEvent event,
      Emitter<AppointmentState> emit) async {}
}
