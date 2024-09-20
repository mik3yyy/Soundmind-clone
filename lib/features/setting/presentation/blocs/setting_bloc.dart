import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_mind/features/Setting/domain/usecases/update_user_details.dart';
import 'package:sound_mind/features/Setting/domain/usecases/change_password.dart';
import 'package:sound_mind/features/setting/domain/usecases/get_user_data.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetUserDetails getUserDetails;
  final UpdateUserDetails updateUserDetails;
  final ChangePassword changePassword;

  SettingBloc({
    required this.getUserDetails,
    required this.updateUserDetails,
    required this.changePassword,
    required Object getSettingData,
  }) : super(SettingInitial()) {
    on<FetchUserDetailsEvent>(_fetchUserDetails);
    on<UpdateUserDetailsEvent>(_updateUserDetails);
    on<ChangePasswordEvent>(_changePassword);
  }

  Future<void> _fetchUserDetails(
      FetchUserDetailsEvent event, Emitter<SettingState> emit) async {
    emit(SettingLoading());

    final result = await getUserDetails.call();
    result.fold(
      (failure) => emit(SettingError(message: failure.message)),
      (userDetails) => emit(SettingLoaded(userDetails: userDetails)),
    );
  }

  Future<void> _updateUserDetails(
      UpdateUserDetailsEvent event, Emitter<SettingState> emit) async {
    emit(SettingLoading());

    final result = await updateUserDetails.call(UpdateUserDetailsParams(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
    ));

    result.fold(
      (failure) => emit(SettingError(message: failure.message)),
      (_) => emit(UpdateSettingSuccess()),
    );
  }

  Future<void> _changePassword(
      ChangePasswordEvent event, Emitter<SettingState> emit) async {
    emit(SettingLoading());

    final result = await changePassword.call(ChangePasswordParams(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    ));

    result.fold(
      (failure) => emit(SettingError(message: failure.message)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
}
