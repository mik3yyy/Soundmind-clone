part of 'Authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class CreatingAccount extends AuthenticationState {}

class SetUserState extends AuthenticationState {}

class CreatingAccountFailure extends AuthenticationState {
  final String message;

  const CreatingAccountFailure({required this.message});
}

class VerifyAccount extends AuthenticationState {
  final Map<String, dynamic> verificationData;

  const VerifyAccount({required this.verificationData});
}

class VerifyingAccountError extends AuthenticationState {
  final Map<String, dynamic> verificationData;
  final String message;

  const VerifyingAccountError(
      {required this.message, required this.verificationData});
}

class VerifingAccount extends AuthenticationState {
  final Map<String, dynamic> verificationData;

  const VerifingAccount({required this.verificationData});
}

class LoginingAccount extends AuthenticationState {}

class LoginAccoiuntFailure extends AuthenticationState {
  final String message;

  const LoginAccoiuntFailure({required this.message});
}

class UserAccount extends AuthenticationState {
  final UserModel user;

  const UserAccount({required this.user});
}

class UpdatingUser extends AuthenticationState {
  final UserModel userModel;

  UpdatingUser({required this.userModel});
}
