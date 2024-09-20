import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Wallet/domain/repositories/wallet_repository.dart';

class GetBanks extends UsecaseWithoutParams<List<Map<String, dynamic>>> {
  final WalletRepository _repository;

  GetBanks({required WalletRepository repository}) : _repository = repository;

  @override
  ResultFuture<List<Map<String, dynamic>>> call() => _repository.getBanks();
}
