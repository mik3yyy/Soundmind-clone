import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class ResendVerificationOtp
    extends UsecaseWithParams<DataMap, ResendVerificationOtpParams> {
  final AuthenticationRepository _repository;

  ResendVerificationOtp({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  ResultFuture<DataMap> call(ResendVerificationOtpParams params) =>
      _repository.resendVerificationOtp(signupKey: params.signupKey);
}

class ResendVerificationOtpParams {
  final String signupKey;

  ResendVerificationOtpParams({required this.signupKey});
}
