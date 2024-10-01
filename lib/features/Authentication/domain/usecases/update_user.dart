import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class UpdateUserUseCase extends UsecaseWithParams<UserModel, UpdateUserParams> {
  final AuthenticationRepository _repository;

  UpdateUserUseCase({required AuthenticationRepository repository})
      : _repository = repository;
  @override
  ResultFuture<UserModel> call(UpdateUserParams params) =>
      _repository.updateUserDetails(
          firstName: params.firstName,
          lastName: params.lastName,
          phoneNumber: params.phoneNumber);
}

class UpdateUserParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  UpdateUserParams(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber});
}
