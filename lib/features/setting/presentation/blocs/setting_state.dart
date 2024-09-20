part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingLoaded extends SettingState {
  final Map<String, dynamic> userDetails;

  const SettingLoaded({required this.userDetails});

  @override
  List<Object> get props => []; // Ensure userDetails is non-nullable
}

class SettingError extends SettingState {
  final String message;

  const SettingError({required this.message});

  @override
  List<Object> get props => [message]; // Ensure message is non-nullable
}

class UpdateSettingSuccess extends SettingState {}

class ChangePasswordSuccess extends SettingState {}
