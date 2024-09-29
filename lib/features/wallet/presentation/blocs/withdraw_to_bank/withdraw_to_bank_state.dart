part of 'withdraw_to_bank_cubit.dart';

abstract class WithdrawToBankState extends Equatable {
  const WithdrawToBankState();

  @override
  List<Object> get props => [];
}

class WithdrawToBankInitial extends WithdrawToBankState {}

class WithdrawToBankLoading extends WithdrawToBankState {}

class WithdrawToBankSuccess extends WithdrawToBankState {}

class WithdrawToBankError extends WithdrawToBankState {
  final String message;

  WithdrawToBankError({required this.message});

  @override
  List<Object> get props => [message];
}
