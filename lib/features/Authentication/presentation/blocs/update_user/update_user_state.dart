part of 'update_user_cubit.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserSuccess extends UpdateUserState {
  final UserModel user;

  const UpdateUserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class UpdateUserError extends UpdateUserState {
  final String message;

  const UpdateUserError({required this.message});

  @override
  List<Object> get props => [message];
}
