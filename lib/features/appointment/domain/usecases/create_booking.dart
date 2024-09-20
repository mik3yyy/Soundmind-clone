import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class CreateBooking extends UsecaseWithParams<void, CreateBookingParams> {
  final AppointmentRepository _repository;

  CreateBooking({required AppointmentRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(CreateBookingParams params) =>
      _repository.createBooking(params.request);
}

class CreateBookingParams {
  final CreateBookingRequest request;

  CreateBookingParams({required this.request});
}
