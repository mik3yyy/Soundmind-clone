import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/Security/domain/usecases/check_pin.dart';
import 'package:sound_mind/features/Security/domain/usecases/clear_pin.dart';
import 'package:sound_mind/features/Security/domain/usecases/is_pin_set.dart';
import 'package:sound_mind/features/Security/domain/usecases/save_pin.dart';

part 'Security_event.dart';
part 'Security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  final SavePin savePin;
  final ClearPin clearPin;
  final CheckPin checkPin;
  final IsPinSetuseCase isPinSets;
  SecurityBloc(
      {required this.checkPin,
      required this.clearPin,
      required this.savePin,
      required this.isPinSets})
      : super(SecurityInitial()) {
    on<AuthenticateEvent>(authenticateHandler);
    on<SetPinEvent>(setPinHandler);
    on<GoToPinPage>(goToPin);
    on<ForgotPinEvent>(forgotPinHandler);
    on<isPinSet>(isPinSetHandler);
  }
  isPinSetHandler(isPinSet event, Emitter emit) async {
    var res = await isPinSets.call();
    res.fold(
      (fil) {},
      (isSet) {
        if (isSet) {
          emit(VerifyPinPage());
        }
      },
    );
  }

  goToPin(GoToPinPage event, Emitter emit) async {
    emit(SetPinPage());
  }

  authenticateHandler(AuthenticateEvent event, Emitter emit) async {
    emit(AuthenticatingState());

    var res = await checkPin.call(event.pin);
    res.fold(
      (failure) {
        emit(AuthenticationErrorState(message: failure.message));
      },
      (status) {
        if (status) {
          emit(AuthenticatedState());
        } else {
          emit(AuthenticationFailureState());
        }
      },
    );
  }

  setPinHandler(SetPinEvent event, Emitter emit) async {
    emit(SettingPin());
    var res = await savePin.call(event.pin);
    res.fold(
      (failure) {
        emit(SettingPinFailed());
      },
      (_) {
        emit(AuthenticatedState());
      },
    );
  }

  forgotPinHandler(ForgotPinEvent event, Emitter emit) async {
    emit(ClearingPin());
    var res = await clearPin.call();
    res.fold(
      (failure) {
        emit(ClearedPinFailed());
      },
      (_) {
        emit(SecurityInitial());
      },
    );
  }
}
