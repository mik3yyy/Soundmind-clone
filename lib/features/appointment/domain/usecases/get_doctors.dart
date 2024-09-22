import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class GetDoctorsUseCase
    extends UsecaseWithParams<List<DoctorModel>, GetDoctorsParams> {
  final AppointmentRepository repository;

  GetDoctorsUseCase({required this.repository});

  @override
  ResultFuture<List<DoctorModel>> call(GetDoctorsParams params) {
    return repository.getDoctors(
        pageNumber: params.pageNumber, pageSize: params.pageSize);
  }
}

class GetDoctorsParams {
  final int pageNumber;
  final int pageSize;

  GetDoctorsParams({required this.pageNumber, required this.pageSize});
}
