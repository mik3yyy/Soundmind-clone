part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

// Event to fetch wallet details
class FetchWalletDetailsEvent extends WalletEvent {}

// Event to fetch wallet transactions
class FetchWalletTransactionsEvent extends WalletEvent {}
