import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';

class IsPinSetuseCase extends UsecaseWithoutParams<bool> {
  final SecurityRepository _repository;

  IsPinSetuseCase({required SecurityRepository repository})
      : _repository = repository;
  @override
  ResultFuture<bool> call() => _repository.isPinSet();
}
