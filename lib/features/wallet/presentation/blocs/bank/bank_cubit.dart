import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/wallet/domain/usecases/get_banks.dart';
import 'package:sound_mind/features/wallet/domain/usecases/resolve_bank.dart';
import 'package:sound_mind/features/wallet/domain/usecases/withdraw_to_bank.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  final GetBanks getBanks;
  final ResolveBankAccount resolveBankAccount;
  final WithdrawToBank withdrawToBankK;

  BankCubit({
    required this.getBanks,
    required this.resolveBankAccount,
    required this.withdrawToBankK,
  }) : super(BankInitial());

  Future<void> fetchBanks() async {
    emit(BankLoading());

    final result = await getBanks.call();
    result.fold(
      (failure) => emit(BankError(message: failure.message)),
      (banks) => emit(BanksLoaded(banks: banks)),
    );
  }

  Future<void> resolveAccount(String accountNumber, String accountBank) async {
    emit(BankLoading());

    final result = await resolveBankAccount.call(
      ResolveBankAccountParams(
          accountNumber: accountNumber, accountBank: accountBank),
    );
    result.fold(
      (failure) => emit(BankError(message: failure.message)),
      (accountDetails) =>
          emit(BankAccountResolved(accountDetails: accountDetails)),
    );
  }

  Future<void> withdrawToBank(
      double amount, String accountNumber, String accountBank) async {
    emit(BankLoading());

    final result = await withdrawToBankK.call(
      WithdrawToBankParams(
          amount: amount,
          accountNumber: accountNumber,
          accountBank: accountBank),
    );
    result.fold(
      (failure) => emit(BankError(message: failure.message)),
      (_) => emit(WithdrawalSuccessful()),
    );
  }
}
