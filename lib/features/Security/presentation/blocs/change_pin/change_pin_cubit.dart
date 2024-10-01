import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/Security/domain/usecases/check_pin.dart';

part 'change_pin_state.dart';

class ChangePinCubit extends Cubit<ChangePinState> {
  final CheckPin checkPin;

  ChangePinCubit({required this.checkPin}) : super(ChangePinInitial());

  Future<void> verifyPin(String pin) async {
    emit(ChangePinLoading());

    final result = await checkPin.call(pin);

    result.fold(
      (failure) => emit(ChangePinError(message: failure.message)),
      (isValid) {
        if (isValid) {
          emit(ChangePinSuccess());
        } else {
          emit(ChangePinInvalid());
        }
      },
    );
  }
}
