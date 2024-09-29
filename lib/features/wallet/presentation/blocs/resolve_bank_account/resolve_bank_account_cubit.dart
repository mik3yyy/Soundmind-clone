import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/wallet/domain/usecases/resolve_bank.dart';

part 'resolve_bank_account_state.dart';

class ResolveBankAccountCubit extends Cubit<ResolveBankAccountState> {
  final ResolveBankAccount resolveBankAccount;

  ResolveBankAccountCubit({required this.resolveBankAccount})
      : super(ResolveBankAccountInitial());

  Future<void> resolveAccount(String accountNumber, String accountBank) async {
    emit(ResolveBankAccountLoading());

    final result = await resolveBankAccount.call(
      ResolveBankAccountParams(
        accountNumber: accountNumber,
        accountBank: accountBank,
      ),
    );
    result.fold(
      (failure) => emit(ResolveBankAccountError(message: failure.message)),
      (accountDetails) =>
          emit(ResolveBankAccountSuccess(accountDetails: accountDetails)),
    );
  }
}
