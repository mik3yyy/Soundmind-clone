import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/wallet/domain/repositories/wallet_repository.dart';

class GetUserWallet extends UsecaseWithoutParams<Map<String, dynamic>> {
  final WalletRepository _repository;

  GetUserWallet({required WalletRepository repository})
      : _repository = repository;

  @override
  ResultFuture<Map<String, dynamic>> call() => _repository.getUserWallet();
}
