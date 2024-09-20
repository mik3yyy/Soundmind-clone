import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/features/appointment/data/models/MakePaymentBookingReq.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class MakePaymentForAppointment
    extends UsecaseWithParams<void, MakePaymentForAppointmentParams> {
  final AppointmentRepository _repository;

  MakePaymentForAppointment({required AppointmentRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(MakePaymentForAppointmentParams params) =>
      _repository.makePaymentForAppointment(params.request);
}

class MakePaymentForAppointmentParams {
  final MakePaymentForAppointmentRequest request;

  MakePaymentForAppointmentParams({required this.request});
}
