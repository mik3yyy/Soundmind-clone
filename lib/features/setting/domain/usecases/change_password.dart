import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/setting/domain/repositories/setting_repository.dart';

class ChangePassword extends UsecaseWithParams<void, ChangePasswordParams> {
  final SettingRepository _repository;

  ChangePassword({required SettingRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(ChangePasswordParams params) =>
      _repository.changePassword(
        oldPassword: params.oldPassword,
        newPassword: params.newPassword,
        confirmPassword: params.confirmPassword,
      );
}

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
