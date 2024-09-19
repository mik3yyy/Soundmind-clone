part of 'Security_bloc.dart';

abstract class SecurityEvent extends Equatable {
  const SecurityEvent();

  @override
  List<Object> get props => [];
}

class SetPinEvent extends SecurityEvent {
  final String pin;

  const SetPinEvent({required this.pin});
}

class AuthenticateEvent extends SecurityEvent {
  final String pin;

  const AuthenticateEvent({required this.pin});
}

class ForgotPinEvent extends SecurityEvent {}

class isPinSet extends SecurityEvent {}

class GoToPinPage extends SecurityEvent {}
