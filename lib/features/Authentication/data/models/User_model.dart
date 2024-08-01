// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sound_mind/core/utils/string_extension.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/domain/entities/User_entity.dart';

class UserModel extends User {
  final int uid;
  final bool isEmailVerified;
  final int expires;
  final String token;
  UserModel({
    required this.uid,
    required this.isEmailVerified,
    required this.expires,
    required this.token,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
  });

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    int? uid,
    String? phoneNumber,
    bool? isEmailVerified,
    String? token,
    int? expires,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      expires: expires ?? this.expires,
      token: token ?? this.token,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      expires: map['expires'] as int,
      token: map['token'] as String,
      isEmailVerified: map['isEmailVerified'] as bool,
      uid: map['uid'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }
  factory UserModel.fromLoginResponse(Map<String, dynamic> map) {
    DataMap data = map['data'];
    return UserModel(
      email: data['email'] as String,
      expires: data['expires'] as int,
      token: data['token'] as String,
      isEmailVerified: data['isEmailVerified'] as bool,
      uid: data['userId'] as int,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      phoneNumber: (data['middleName'] as String?).nullToEmpty,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
