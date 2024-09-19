import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/exceptions.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Security/data/datasources/Security_hive_data_source.dart';
import 'package:sound_mind/features/Security/domain/repositories/Security_repository.dart';

class SecurityRepositoryImpl extends SecurityRepository {
  final SecurityHiveDataSource _securityHiveDataSource;

  SecurityRepositoryImpl(
      {required SecurityHiveDataSource securityHiveDataSource})
      : _securityHiveDataSource = securityHiveDataSource;
  @override
  ResultFuture<bool> checkPin({required String pin}) async {
    try {
      bool res = await _securityHiveDataSource.checkPin(pin: pin);
      return Right(res);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  ResultVoid clearPin() async {
    try {
      await _securityHiveDataSource.clearPin();
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  ResultVoid savePin({required String pin}) async {
    try {
      await _securityHiveDataSource.setPin(pin: pin);
      return Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  ResultFuture<bool> isPinSet() async {
    try {
      bool res = await _securityHiveDataSource.isPinSet();
      return Right(res);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
