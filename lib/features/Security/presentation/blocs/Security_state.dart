part of 'Security_bloc.dart';

abstract class SecurityState extends Equatable {
  const SecurityState();

  @override
  List<Object> get props => [];
}

class SecurityInitial extends SecurityState {}

class SetPinPage extends SecurityState {}

class SettingPin extends SecurityState {}

class SettingPinFailed extends SecurityState {}

class AuthenticatedState extends SecurityState {}

class AuthenticationFailureState extends SecurityState {}

class AuthenticationErrorState extends SecurityState {
  final String message;

  const AuthenticationErrorState({required this.message});
}

class AuthenticatingState extends SecurityState {}

class ClearingPin extends SecurityState {}

class ClearedPinFailed extends SecurityState {}

class VerifyPinPage extends SecurityState {}

// class ClearedPinDone/ extends SecurityState {}
