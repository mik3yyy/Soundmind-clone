import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/domain/usecases/make_appointment_payment.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final MakePaymentForAppointment makePaymentForAppointment;

  PaymentCubit({required this.makePaymentForAppointment})
      : super(PaymentInitial());

  Future<void> makePaymentEvent(MakePaymentForAppointmentParams params) async {
    emit(PaymentLoading());

    final result = await makePaymentForAppointment.call(params);
    result.fold(
      (failure) => emit(PaymentError(message: failure.message)),
      (_) => emit(PaymentSuccess()),
    );
  }
}
