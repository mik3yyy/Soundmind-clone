part of 'get_bank_transactions_cubit.dart';

abstract class GetBankTransactionsState extends Equatable {
  const GetBankTransactionsState();

  @override
  List<Object> get props => [];
}

class GetBankTransactionsInitial extends GetBankTransactionsState {}

class GetBankTransactionsLoading extends GetBankTransactionsState {}

class GetBankTransactionsLoaded extends GetBankTransactionsState {
  final List<Map<String, dynamic>> transactions;

  const GetBankTransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class GetBankTransactionsError extends GetBankTransactionsState {
  final String message;

  const GetBankTransactionsError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetBankTransactionsEmpty extends GetBankTransactionsState {
  final String message;

  const GetBankTransactionsEmpty({required this.message});

  @override
  List<Object> get props => [message];
}
