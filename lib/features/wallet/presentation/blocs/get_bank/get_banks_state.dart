part of 'get_banks_cubit.dart';

abstract class GetBanksState extends Equatable {
  const GetBanksState();

  @override
  List<Object> get props => [];
}

class GetBanksInitial extends GetBanksState {}

class GetBanksLoading extends GetBanksState {}

class GetBanksLoaded extends GetBanksState {
  final List<Map<String, dynamic>> banks;

  GetBanksLoaded({required this.banks});

  @override
  List<Object> get props => [banks];
}

class GetBanksError extends GetBanksState {
  final String message;

  GetBanksError({required this.message});

  @override
  List<Object> get props => [message];
}
