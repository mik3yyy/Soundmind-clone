import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/appointment.dart';
import 'package:sound_mind/features/appointment/data/models/booking.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_accepted_appointment.dart';

part 'get_accepted_appointments_state.dart';

class AcceptedAppointmentsCubit extends Cubit<AcceptedAppointmentsState> {
  final GetAcceptedAppointments getAcceptedAppointments;

  AcceptedAppointmentsCubit(this.getAcceptedAppointments)
      : super(AcceptedAppointmentsInitial());

  Future<void> fetchAcceptedAppointments() async {
    emit(AcceptedAppointmentsLoading());

    final result = await getAcceptedAppointments();

    result.fold(
      (error) => emit(AcceptedAppointmentsError(error.toString())),
      (appointments) => emit(AcceptedAppointmentsLoaded(appointments)),
    );
  }
}
