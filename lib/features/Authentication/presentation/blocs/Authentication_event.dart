part of 'Authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateAccountEvent extends AuthenticationEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String depressionScore;

  const CreateAccountEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.depressionScore,
      required this.confirmPassword,
      required this.phoneNumber});
}

class LoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class VerifyEmailEvent extends AuthenticationEvent {
  final DataMap verificationData;
  final String otp;

  VerifyEmailEvent({required this.verificationData, required this.otp});
}
