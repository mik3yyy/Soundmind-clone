import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/wallet/domain/repositories/wallet_repository.dart';

class ConfirmWalletTopUp
    extends UsecaseWithParams<void, ConfirmWalletTopUpParams> {
  final WalletRepository _repository;

  ConfirmWalletTopUp({required WalletRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(ConfirmWalletTopUpParams params) =>
      _repository.confirmWalletTopUp(
        transactionReference: params.transactionReference,
        flutterwaveTransactionID: params.flutterwaveTransactionID,
      );
}

class ConfirmWalletTopUpParams {
  final String transactionReference;
  final String flutterwaveTransactionID;

  ConfirmWalletTopUpParams({
    required this.transactionReference,
    required this.flutterwaveTransactionID,
  });
}
