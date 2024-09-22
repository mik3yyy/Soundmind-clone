import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/doctor_detail.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_doctor.detail.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;

  DoctorDetailsCubit({required this.getDoctorDetailsUseCase})
      : super(DoctorDetailsInitial());

  Future<void> fetchDoctorDetails(int physicianId) async {
    emit(DoctorDetailsLoading());

    final result = await getDoctorDetailsUseCase
        .call(GetDoctorDetailsParams(physicianId: physicianId));

    result.fold(
      (failure) => emit(DoctorDetailsError(message: failure.message)),
      (doctor) => emit(DoctorDetailsLoaded(doctor: doctor)),
    );
  }
}
