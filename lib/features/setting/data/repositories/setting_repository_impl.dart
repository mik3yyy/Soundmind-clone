import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';

import 'package:sound_mind/features/setting/data/datasources/setting_hive_data_source.dart';
import 'package:sound_mind/features/setting/data/datasources/setting_remote_data_source.dart';
import 'package:sound_mind/features/setting/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl extends SettingRepository {
  final SettingRemoteDataSource _remoteDataSource;
  final SettingHiveDataSource _hiveDataSource;

  SettingRepositoryImpl({
    required SettingRemoteDataSource remoteDataSource,
    required SettingHiveDataSource hiveDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _hiveDataSource = hiveDataSource;

  @override
  ResultFuture<Map<String, dynamic>> getUserDetails() async {
    try {
      final remoteDetails = await _remoteDataSource.getUserDetails();
      await _hiveDataSource.saveUserDetails(userDetails: remoteDetails);
      return Right(remoteDetails);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    } catch (e) {
      try {
        final cachedDetails = await _hiveDataSource.getUserDetails();
        return Right(cachedDetails);
      } catch (e) {
        return const Left(CacheFailure('No cached user details found'));
      }
    }
  }

  @override
  ResultFuture<void> updateUserDetails({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      await _remoteDataSource.updateUserDetails(
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
