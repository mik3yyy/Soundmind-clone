import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/wallet/domain/repositories/wallet_repository.dart';

class InitiateWalletTopUp
    extends UsecaseWithParams<Map<String, dynamic>, InitiateWalletTopUpParams> {
  final WalletRepository _repository;

  InitiateWalletTopUp({required WalletRepository repository})
      : _repository = repository;

  @override
  ResultFuture<Map<String, dynamic>> call(InitiateWalletTopUpParams params) =>
      _repository.initiateWalletTopUp(amount: params.amount);
}

class InitiateWalletTopUpParams {
  final double amount;

  InitiateWalletTopUpParams({required this.amount});
}
