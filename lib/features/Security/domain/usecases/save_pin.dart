import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';

class SavePin extends UsecaseWithParams<void, String> {
  final SecurityRepository _repository;

  SavePin({required SecurityRepository repository}) : _repository = repository;
  @override
  ResultFuture<void> call(String pin) => _repository.savePin(pin: pin);
}
