import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/setting/domain/repositories/setting_repository.dart';

class UpdateUserDetails
    extends UsecaseWithParams<void, UpdateUserDetailsParams> {
  final SettingRepository _repository;

  UpdateUserDetails({required SettingRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(UpdateUserDetailsParams params) =>
      _repository.updateUserDetails(
        firstName: params.firstName,
        lastName: params.lastName,
        email: params.email,
      );
}

class UpdateUserDetailsParams {
  final String firstName;
  final String lastName;
  final String email;

  UpdateUserDetailsParams({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
