import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/datasources/Authentication_remote_data_source.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/Authentication/domain/repositories/Authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(
      {required AuthenticationRemoteDataSource authenticationRemoteDataSource})
      : _authenticationRemoteDataSource = authenticationRemoteDataSource;
  @override
  ResultFuture<DataMap> createAccount(
      {required String email,
      required String password,
      required String depressionScore,
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
        confirmPassword: confirmPassword,
        firstName: firstName,
        lastName: lastName,
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
        return Right(UserModel.fromLoginResponse(userData));
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
      return Right(userModel);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    } catch (e) {
      return const Left(ServerFailure(ApiError.unknownError));
    }
  }
}
