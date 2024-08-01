import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class VerifyEmail extends UsecaseWithParams<UserModel, VerifyEmailParams> {
  final AuthenticationRepository _repository;

  VerifyEmail({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<UserModel> call(VerifyEmailParams params) =>
      _repository.verifyEmail(otp: params.otp, securityKey: params.securityKey);
}

class VerifyEmailParams {
  final String otp;
  final String securityKey;

  VerifyEmailParams({required this.otp, required this.securityKey});
}
