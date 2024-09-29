import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/wallet/domain/repositories/wallet_repository.dart';

class WithdrawToBank extends UsecaseWithParams<void, WithdrawToBankParams> {
  final WalletRepository _repository;

  WithdrawToBank({required WalletRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(WithdrawToBankParams params) =>
      _repository.withdrawToBank(
        amount: params.amount,
        accountNumber: params.accountNumber,
        accountBank: params.accountBank,
      );
}

class WithdrawToBankParams {
  final double amount;
  final String accountNumber;
  final String accountBank;

  WithdrawToBankParams({
    required this.amount,
    required this.accountNumber,
    required this.accountBank,
  });
}
