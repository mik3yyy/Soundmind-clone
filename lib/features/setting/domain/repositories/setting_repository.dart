import 'package:sound_mind/core/utils/typedef.dart';

abstract class SettingRepository {
  // Define abstract methods here
  ResultFuture<Map<String, dynamic>> getUserDetails();
  ResultFuture<void> updateUserDetails({
    required String firstName,
    required String lastName,
    required String email,
  });
  ResultFuture<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
