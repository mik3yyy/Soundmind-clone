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

  chnageState({Sort? sort, Display? display, String? search}) {
    if (state is DoctorLoaded) {
      var s = state as DoctorLoaded;
      List<DoctorModel> doctors = s.doctors;
      if (sort != null) {
        doctors = sortDoctors(doctors, sort);
      }

      emit(
        DoctorLoaded(
            doctors: doctors,
            sort: sort ?? s.sort,
            display: display ?? s.display,
            search: search ?? s.search),
      );
    }
  }
}

List<DoctorModel> sortDoctors(List<DoctorModel> doctors, Sort sortType) {
  List<DoctorModel> sortedDoctors =
      List.from(doctors); // Create a copy of the list

  switch (sortType) {
    case Sort.a_z:
      sortedDoctors.sort((a, b) => a.firstName!.compareTo(b.firstName!));
      break;
    case Sort.z_a:
      sortedDoctors.sort((a, b) => b.firstName!.compareTo(a.firstName!));
      break;
    case Sort.Rl_h:
      sortedDoctors.sort((a, b) => a.ratingAverage.compareTo(b.ratingAverage));
      break;
    case Sort.Rh_l:
      sortedDoctors.sort((a, b) => b.ratingAverage.compareTo(a.ratingAverage));
      break;
    case Sort.Ph_l:
      sortedDoctors
          .sort((a, b) => b.consultationRate.compareTo(a.consultationRate));
      break;
    case Sort.Pl_h:
      sortedDoctors
          .sort((a, b) => a.consultationRate.compareTo(b.consultationRate));
      break;
    case Sort.most_experienced:
      sortedDoctors.sort((a, b) => b.yoe.compareTo(a.yoe));
      break;
  }

  return sortedDoctors;
}
