import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';

class ClearPin extends UsecaseWithoutParams<void> {
  final SecurityRepository _repository;

  ClearPin({required SecurityRepository repository}) : _repository = repository;
  @override
  ResultFuture<void> call() => _repository.clearPin();
}
