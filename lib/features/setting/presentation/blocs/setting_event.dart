part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class UpdateUserDetailsEvent extends SettingEvent {
  final String firstName;
  final String lastName;
  final String email;

  const UpdateUserDetailsEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object?> get props => [firstName, lastName, email];
}

class FetchUserDetailsEvent extends SettingEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangePasswordEvent extends SettingEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword, confirmPassword];
}
