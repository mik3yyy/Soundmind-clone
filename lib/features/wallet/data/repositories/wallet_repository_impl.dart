import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/exceptions.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:sound_mind/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  final WalletRemoteDataSource _remoteDataSource;

  WalletRepositoryImpl({required WalletRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  ResultFuture<Map<String, dynamic>> getUserWallet() async {
    try {
      final wallet = await _remoteDataSource.getUserWallet();
      return Right(wallet);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<Map<String, dynamic>>> getUserWalletTransactions() async {
    try {
      final transactions = await _remoteDataSource.getUserWalletTransactions();
      return Right(transactions);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<Map<String, dynamic>> initiateWalletTopUp(
      {required double amount}) async {
    try {
      final result =
          await _remoteDataSource.initiateWalletTopUp(amount: amount);
      return Right(result);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> confirmWalletTopUp(
      {required String transactionReference,
      required String flutterwaveTransactionID}) async {
    try {
      await _remoteDataSource.confirmWalletTopUp(
        transactionReference: transactionReference,
        flutterwaveTransactionID: flutterwaveTransactionID,
      );
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<List<Map<String, dynamic>>> getBanks() async {
    try {
      final banks = await _remoteDataSource.getBanks();
      return Right(banks);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<Map<String, dynamic>> resolveBankAccount(
      {required String accountNumber, required String accountBank}) async {
    try {
      final result = await _remoteDataSource.resolveBankAccount(
        accountNumber: accountNumber,
        accountBank: accountBank,
      );
      return Right(result);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> withdrawToBank(
      {required double amount,
      required String accountNumber,
      required String accountBank}) async {
    try {
      await _remoteDataSource.withdrawToBank(
        amount: amount,
        accountNumber: accountNumber,
        accountBank: accountBank,
      );
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
