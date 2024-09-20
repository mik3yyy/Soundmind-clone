import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Wallet/data/datasources/wallet_remote_data_source.dart';
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
    } catch (e) {
      return Left(ServerFailure("Failed to fetch wallet details"));
    }
  }

  @override
  ResultFuture<List<Map<String, dynamic>>> getUserWalletTransactions() async {
    try {
      final transactions = await _remoteDataSource.getUserWalletTransactions();
      return Right(transactions);
    } catch (e) {
      return const Left(ServerFailure("Failed to fetch wallet transactions"));
    }
  }

  @override
  ResultFuture<Map<String, dynamic>> initiateWalletTopUp(
      {required double amount}) async {
    try {
      final result =
          await _remoteDataSource.initiateWalletTopUp(amount: amount);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure("Failed to initiate wallet top-up"));
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
    } catch (e) {
      return const Left(ServerFailure("Failed to confirm wallet top-up"));
    }
  }

  @override
  ResultFuture<List<Map<String, dynamic>>> getBanks() async {
    try {
      final banks = await _remoteDataSource.getBanks();
      return Right(banks);
    } catch (e) {
      return const Left(ServerFailure("Failed to fetch banks"));
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
    } catch (e) {
      return const Left(ServerFailure("Failed to resolve bank account"));
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
    } catch (e) {
      return const Left(ServerFailure("Failed to withdraw to bank"));
    }
  }
}
