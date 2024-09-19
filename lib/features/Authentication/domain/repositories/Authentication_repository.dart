import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';

abstract class AuthenticationRepository {
  ResultFuture<DataMap> createAccount({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String depressionScore,
    required int gender,
    required String dob,
    required String phoneNumber,
  });
  ResultFuture<UserModel> login({
    required String email,
    required String password,
  });
  ResultFuture<UserModel> verifyEmail({
    required String otp,
    required String securityKey,
  });
  ResultFuture<UserModel> checkUser();
}
