import 'package:sound_mind/core/utils/typedef.dart';

abstract class WalletRepository {
  ResultFuture<Map<String, dynamic>> getUserWallet();
  ResultFuture<List<Map<String, dynamic>>> getUserWalletTransactions();
  ResultFuture<Map<String, dynamic>> initiateWalletTopUp(
      {required double amount});
  ResultFuture<void> confirmWalletTopUp(
      {required String transactionReference,
      required String flutterwaveTransactionID});
  ResultFuture<List<Map<String, dynamic>>> getBanks();
  ResultFuture<Map<String, dynamic>> resolveBankAccount(
      {required String accountNumber, required String accountBank});
  ResultFuture<void> withdrawToBank(
      {required double amount,
      required String accountNumber,
      required String accountBank});
}
