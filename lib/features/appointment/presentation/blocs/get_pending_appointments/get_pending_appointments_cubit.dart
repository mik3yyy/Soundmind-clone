import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_pending_appointment.dart';

part 'get_pending_appointments_state.dart';

class PendingAppointmentsCubit extends Cubit<PendingAppointmentsState> {
  final GetPendingAppointments getPendingAppointments;

  PendingAppointmentsCubit(this.getPendingAppointments)
      : super(PendingAppointmentsInitial());

  Future<void> fetchPendingAppointments() async {
    emit(PendingAppointmentsLoading());

    final result = await getPendingAppointments();

    result.fold(
      (error) => emit(PendingAppointmentsError(error.toString())),
      (appointments) => emit(PendingAppointmentsLoaded(appointments)),
    );
  }
}
