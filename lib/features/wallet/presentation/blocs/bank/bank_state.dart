part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();

  @override
  List<Object?> get props => [];
}

class BankInitial extends BankState {}

class BankLoading extends BankState {}

class BanksLoaded extends BankState {
  final List<Map<String, dynamic>> banks;

  const BanksLoaded({required this.banks});

  @override
  List<Object?> get props => [banks];
}

class BankAccountResolved extends BankState {
  final Map<String, dynamic> accountDetails;

  const BankAccountResolved({required this.accountDetails});

  @override
  List<Object?> get props => [accountDetails];
}

class WithdrawalSuccessful extends BankState {}

class BankError extends BankState {
  final String message;

  const BankError({required this.message});

  @override
  List<Object?> get props => [message];
}
