import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/Authentication/domain/usecases/update_user.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUserUseCase updateUserUseCase;

  UpdateUserCubit({required this.updateUserUseCase})
      : super(UpdateUserInitial());

  Future<void> updateUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    emit(UpdateUserLoading());

    final result = await updateUserUseCase.call(
      UpdateUserParams(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      ),
    );

    result.fold(
      (failure) => emit(UpdateUserError(message: failure.message)),
      (user) => emit(UpdateUserSuccess(user: user)),
    );
  }
}
