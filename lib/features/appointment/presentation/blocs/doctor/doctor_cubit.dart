import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/data/models/doctor.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_doctors.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final GetDoctorsUseCase getDoctorsUseCase;

  DoctorCubit({required this.getDoctorsUseCase}) : super(DoctorInitial());

  Future<void> fetchDoctors(
      {required int pageNumber, required int pageSize}) async {
    emit(DoctorLoading());

    final result = await getDoctorsUseCase
        .call(GetDoctorsParams(pageNumber: pageNumber, pageSize: pageSize));

    result.fold(
      (failure) => emit(DoctorError(message: failure.message)),
      (doctors) => emit(DoctorLoaded(doctors: doctors)),
    );
  }
}
