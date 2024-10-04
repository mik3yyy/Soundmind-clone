import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class LogOutUsecase extends UsecaseWithoutParams<void> {
  final AuthenticationRepository _repository;

  LogOutUsecase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<void> call() => _repository.logout();
}
