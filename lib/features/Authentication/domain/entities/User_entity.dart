import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  User(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [email, firstName, lastName, phoneNumber];
}
