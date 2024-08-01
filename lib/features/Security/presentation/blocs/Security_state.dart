part of 'Security_bloc.dart';

abstract class SecurityState extends Equatable {
  const SecurityState();

  @override
  List<Object> get props => [];
}

class SecurityInitial extends SecurityState {}
