part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final Map<String, dynamic> wallet;

  const WalletLoaded({required this.wallet});

  @override
  List<Object?> get props => [wallet];
}

class WalletTransactionsLoaded extends WalletState {
  final List<Map<String, dynamic>> transactions;

  const WalletTransactionsLoaded({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class WalletError extends WalletState {
  final String message;

  const WalletError({required this.message});

  @override
  List<Object?> get props => [message];
}
