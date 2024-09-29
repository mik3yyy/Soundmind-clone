import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/wallet/domain/usecases/withdraw_to_bank.dart';

part 'withdraw_to_bank_state.dart';

class WithdrawToBankCubit extends Cubit<WithdrawToBankState> {
  final WithdrawToBank withdrawToBank;

  WithdrawToBankCubit({required this.withdrawToBank})
      : super(WithdrawToBankInitial());

  Future<void> withdrawToBankHandler(
      double amount, String accountNumber, String accountBank) async {
    emit(WithdrawToBankLoading());

    final result = await withdrawToBank.call(
      WithdrawToBankParams(
        amount: amount,
        accountNumber: accountNumber,
        accountBank: accountBank,
      ),
    );
    result.fold(
      (failure) => emit(WithdrawToBankError(message: failure.message)),
      (_) => emit(WithdrawToBankSuccess()),
    );
  }
}
