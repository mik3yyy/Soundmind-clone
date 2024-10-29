import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_hive_data_source.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;
  final AuthenticationHiveDataSource _authenticationHiveDataSource;
  AuthenticationRepositoryImpl(
      {required AuthenticationRemoteDataSource authenticationRemoteDataSource,
      required AuthenticationHiveDataSource authenticationHiveDataSource})
      : _authenticationRemoteDataSource = authenticationRemoteDataSource,
        _authenticationHiveDataSource = authenticationHiveDataSource;
  @override
  ResultFuture<DataMap> createAccount(
      {required String email,
      required String password,
      required String depressionScore,
      required int gender,
      required String dob,
      required String confirmPassword,
      required String firstName,
      required String lastName,
      required String phoneNumber}) async {
    try {
      var verificationData =
          await _authenticationRemoteDataSource.createAccount(
        email: email,
        password: password,
        depressionScore: depressionScore,
        gender: gender,
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
        dob: dob,
        phoneNumber: phoneNumber,
      );
      return Right(verificationData);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<UserModel> login(
      {required String email, required String password}) async {
    try {
      DataMap userData = await _authenticationRemoteDataSource.login(
        email: email,
        password: password,
      );
      print(userData);
      if (userData['data']['isEmailVerified']) {
        UserModel userModel = UserModel.fromLoginResponse(userData);

        _authenticationHiveDataSource.saveUser(userModel: userModel);
        return Right(userModel);
      } else {
        return Left(ServerFailure("User Not verified", data: userData));
      }
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<UserModel> verifyEmail(
      {required String otp, required String securityKey}) async {
    try {
      UserModel userModel = await _authenticationRemoteDataSource.verifyEmail(
          otp: otp, securityKey: securityKey);
      _authenticationHiveDataSource.saveUser(userModel: userModel);
      return Right(userModel);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    } catch (e) {
      return const Left(ServerFailure(ApiError.unknownError));
    }
  }

  @override
  ResultFuture<UserModel> checkUser() async {
    try {
      UserModel userModel = await _authenticationHiveDataSource.getUser();

      return Right(userModel);
    } catch (e) {
      print(e.toString());
      return const Left(CacheFailure("No User"));
    }
  }

  @override
  ResultFuture<void> changePassword(
      {required String old,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      await _authenticationRemoteDataSource.changePassword(
          old: old, newPassword: newPassword, confirmPassword: confirmPassword);

      return Right(null);
    } on ApiError catch (e) {
      print(e.toString());
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<UserModel> updateUserDetails({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      var newDetail = await _authenticationRemoteDataSource.updateUserDetails(
          firstName: firstName, lastName: lastName, phoneNumber: phoneNumber);
      UserModel userModel = await _authenticationHiveDataSource.getUser();

      UserModel newUser = userModel.copyWith(
          lastName: lastName, firstName: firstName, phoneNumber: phoneNumber);

      _authenticationHiveDataSource.saveUser(userModel: newUser);
      return Right(userModel);
    } on ApiError catch (e) {
      print(e.toString());
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> logout() async {
    // TODO: implement logout
    try {
      await _authenticationHiveDataSource.deleteUser();

      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure("No User"));
    }
  }

  @override
  ResultFuture<DataMap> resendVerificationOtp({
    required String signupKey,
  }) async {
    try {
      DataMap result =
          await _authenticationRemoteDataSource.resendVerificationOtp(
        signupKey: signupKey,
      );
      return Right(result);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
