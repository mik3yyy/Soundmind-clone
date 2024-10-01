part of 'change_pin_cubit.dart';

abstract class ChangePinState extends Equatable {
  const ChangePinState();

  @override
  List<Object> get props => [];
}

class ChangePinInitial extends ChangePinState {}

class ChangePinLoading extends ChangePinState {}

class ChangePinSuccess extends ChangePinState {}

class ChangePinInvalid extends ChangePinState {}

class ChangePinError extends ChangePinState {
  final String message;

  const ChangePinError({required this.message});

  @override
  List<Object> get props => [message];
}
