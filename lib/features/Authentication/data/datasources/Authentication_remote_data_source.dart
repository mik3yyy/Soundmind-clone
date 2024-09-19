import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<DataMap> createAccount(
      {required String email,
      required String password,
      required String confirmPassword,
      required String depressionScore,
      required String firstName,
      required String lastName,
      required int gender,
      required String dob,
      required String phoneNumber});
  Future<DataMap> login({required String email, required String password});
  Future<UserModel> verifyEmail(
      {required String otp, required String securityKey});
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final Network _network;

  AuthenticationRemoteDataSourceImpl({required Network network})
      : _network = network;
  @override
  Future<DataMap> createAccount(
      {required String email,
      required String password,
      required String confirmPassword,
      required String depressionScore,
      required String firstName,
      required int gender,
      required String dob,
      required String lastName,
      required String phoneNumber}) async {
    Response response = await _network.call(
      "/Registration",
      RequestMethod.post,

      // useUrlEncoded: true,
      data: json.encode({
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "dob": dob,
        "passwordConfirmation": confirmPassword,
        "depressionSeverityScore": double.parse(depressionScore).toInt()
      }),
    );
    return response.data;
  }

  @override
  Future<DataMap> login(
      {required String email, required String password}) async {
    Response response = await _network.call(
      "/Auth/Login",
      RequestMethod.post,
      data: {
        "email": email,
        "password": password,
      },
    );
    return response.data;
  }

  @override
  Future<UserModel> verifyEmail(
      {required String otp, required String securityKey}) async {
    Response response = await _network.call(
      "/Registration/VerifyAccount",
      RequestMethod.patch,
      data: {
        "otp": otp,
        "signupKey": securityKey,
      },
    );
    print(response.data);
    return UserModel.fromLoginResponse(response.data);
  }
}
