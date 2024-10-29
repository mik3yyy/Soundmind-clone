import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/domain/usecases/rejected_appointment.dart';

part 'get_rejected_appointments_state.dart';

class RejectedAppointmentsCubit extends Cubit<RejectedAppointmentsState> {
  final GetRejectedAppointments getRejectedAppointments;

  RejectedAppointmentsCubit(this.getRejectedAppointments)
      : super(RejectedAppointmentsInitial());

  Future<void> fetchRejectedAppointments() async {
    emit(RejectedAppointmentsLoading());

    final result = await getRejectedAppointments();

    result.fold(
      (error) => emit(RejectedAppointmentsError(error.toString())),
      (appointments) => emit(RejectedAppointmentsLoaded(appointments)),
    );
  }
}
