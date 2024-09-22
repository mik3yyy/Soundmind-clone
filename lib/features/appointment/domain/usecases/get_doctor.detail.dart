import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class GetDoctorDetailsUseCase
    extends UsecaseWithParams<DoctorDetailModel, GetDoctorDetailsParams> {
  final AppointmentRepository repository;

  GetDoctorDetailsUseCase({required this.repository});

  @override
  ResultFuture<DoctorDetailModel> call(GetDoctorDetailsParams params) {
    return repository.getDoctorDetails(physicianId: params.physicianId);
  }
}

class GetDoctorDetailsParams {
  final int physicianId;

  GetDoctorDetailsParams({required this.physicianId});
}
