import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/change_password.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
      : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());

    final result = await changePasswordUseCase.call(
      ChangePasswordUseCaseParams(
        old: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );

    result.fold(
      (failure) => emit(ChangePasswordError(message: failure.message)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
}
