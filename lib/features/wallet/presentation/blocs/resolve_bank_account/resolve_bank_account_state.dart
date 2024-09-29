part of 'resolve_bank_account_cubit.dart';

abstract class ResolveBankAccountState extends Equatable {
  const ResolveBankAccountState();

  @override
  List<Object> get props => [];
}

class ResolveBankAccountInitial extends ResolveBankAccountState {}

class ResolveBankAccountLoading extends ResolveBankAccountState {}

class ResolveBankAccountSuccess extends ResolveBankAccountState {
  final Map<String, dynamic> accountDetails;

  ResolveBankAccountSuccess({required this.accountDetails});

  @override
  List<Object> get props => [accountDetails];
}

class ResolveBankAccountError extends ResolveBankAccountState {
  final String message;

  ResolveBankAccountError({required this.message});

  @override
  List<Object> get props => [message];
}
