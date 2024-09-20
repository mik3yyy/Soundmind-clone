import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/setting/domain/repositories/setting_repository.dart';

class GetUserDetails extends UsecaseWithoutParams<DataMap> {
  final SettingRepository _repository;

  GetUserDetails({required SettingRepository repository})
      : _repository = repository;

  @override
  ResultFuture<DataMap> call() => _repository.getUserDetails();
}
