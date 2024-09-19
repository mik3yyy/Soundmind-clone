import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class CreateAccount extends UsecaseWithParams<DataMap, CreateAccountParams> {
  final AuthenticationRepository _repository;

  CreateAccount({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<DataMap> call(CreateAccountParams params) =>
      _repository.createAccount(
        email: params.email,
        dob: params.dob,
        gender: params.gender,
        password: params.password,
        confirmPassword: params.confirmPassword,
        depressionScore: params.depressionScore,
        firstName: params.firstName,
        lastName: params.lastName,
        phoneNumber: params.phoneNumber,
      );
}

class CreateAccountParams {
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String dob;

  final String lastName;
  final String depressionScore;
  final String phoneNumber;
  final int gender;

  CreateAccountParams(
      {required this.email,
      required this.gender,
      required this.dob,
      required this.password,
      required this.confirmPassword,
      required this.depressionScore,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});
}
