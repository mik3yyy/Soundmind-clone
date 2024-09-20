part of 'topup_wallet_cubit.dart';

abstract class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object?> get props => [];
}

class TopUpInitial extends TopUpState {}

class TopUpLoading extends TopUpState {}

class TopUpInitiated extends TopUpState {
  final Map<String, dynamic> topUpDetails;

  const TopUpInitiated({required this.topUpDetails});

  @override
  List<Object?> get props => [topUpDetails];
}

class TopUpConfirmed extends TopUpState {}

class TopUpError extends TopUpState {
  final String message;

  const TopUpError({required this.message});

  @override
  List<Object?> get props => [message];
}
