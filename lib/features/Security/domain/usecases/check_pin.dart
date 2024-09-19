import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';

class CheckPin extends UsecaseWithParams<bool, String> {
  final SecurityRepository _repository;

  CheckPin({required SecurityRepository repository}) : _repository = repository;
  @override
  ResultFuture<bool> call(String pin) => _repository.checkPin(pin: pin);
}
