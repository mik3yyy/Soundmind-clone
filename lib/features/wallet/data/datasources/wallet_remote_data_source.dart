import 'dart:convert';
import 'package:sound_mind/core/network/network.dart';

abstract class WalletRemoteDataSource {
  Future<Map<String, dynamic>> getUserWallet();
  Future<List<Map<String, dynamic>>> getUserWalletTransactions();
  Future<Map<String, dynamic>> initiateWalletTopUp({required double amount});
  Future<void> confirmWalletTopUp(
      {required String transactionReference,
      required String flutterwaveTransactionID});
  Future<List<Map<String, dynamic>>> getBanks();
  Future<Map<String, dynamic>> resolveBankAccount(
      {required String accountNumber, required String accountBank});
  Future<void> withdrawToBank(
      {required double amount,
      required String accountNumber,
      required String accountBank});
}

class WalletRemoteDataSourceImpl extends WalletRemoteDataSource {
  final Network _network;

  WalletRemoteDataSourceImpl({required Network network}) : _network = network;

  @override
  Future<Map<String, dynamic>> getUserWallet() async {
    final response =
        await _network.call("/Wallet/GetUserWallet", RequestMethod.get);
    return response.data['data'];
  }

  @override
  Future<List<Map<String, dynamic>>> getUserWalletTransactions() async {
    final response = await _network.call(
        "/Wallet/GetUserWalletTransactions", RequestMethod.get);
    return (response.data['data'] as List)
        .map((transaction) => transaction as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<Map<String, dynamic>> initiateWalletTopUp(
      {required double amount}) async {
    final response = await _network.call(
      "/Wallet/InitiateWalletTopup",
      RequestMethod.post,
      data: json.encode({"amount": amount}),
    );
    return response.data;
  }

  @override
  Future<void> confirmWalletTopUp(
      {required String transactionReference,
      required String flutterwaveTransactionID}) async {
    await _network.call(
      "/Wallet/ConfirmWalletTopup",
      RequestMethod.post,
      data: json.encode({
        "transactionReference": transactionReference,
        "flutterwaveTransactionID": flutterwaveTransactionID,
      }),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getBanks() async {
    final response = await _network.call("/Wallet/GetBanks", RequestMethod.get);
    return (response.data['data'] as List)
        .map((bank) => bank as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<Map<String, dynamic>> resolveBankAccount(
      {required String accountNumber, required String accountBank}) async {
    final response = await _network.call(
      "/Wallet/ResolveBankAccount",
      RequestMethod.post,
      data: json.encode({
        "accountNumber": accountNumber,
        "accountBank": accountBank,
      }),
    );
    return response.data['data'];
  }

  @override
  Future<void> withdrawToBank(
      {required double amount,
      required String accountNumber,
      required String accountBank}) async {
    await _network.call(
      "/Wallet/WithdrawToBank",
      RequestMethod.post,
      data: json.encode({
        "amount": amount,
        "accountNumber": accountNumber,
        "accountBank": accountBank,
      }),
    );
  }
}
