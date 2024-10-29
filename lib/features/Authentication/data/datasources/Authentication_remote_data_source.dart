import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';
import 'package:sound_mind/features/setting/domain/usecases/change_password.dart';

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

  Future<DataMap> updateUserDetails({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  });
  Future<DataMap> changePassword(
      {required String old,
      required String newPassword,
      required String confirmPassword});
  Future<DataMap> resendVerificationOtp({required String signupKey});
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

  @override
  Future<DataMap> changePassword(
      {required String old,
      required String newPassword,
      required String confirmPassword}) async {
    Response response = await _network.call(
      "/Settings/ChangePassword",
      RequestMethod.patch,
      data: {
        "oldPassword": old,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      },
    );
    return response.data;
  }

  @override
  Future<DataMap> updateUserDetails(
      {required String firstName,
      required String lastName,
      required String phoneNumber}) async {
    Response response = await _network.call(
      "/Settings/UpdateUserDetails",
      RequestMethod.patch,
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber
      },
    );
    return response.data;
  }

  @override
  Future<DataMap> resendVerificationOtp({required String signupKey}) async {
    Response response = await _network.call(
      "/Registration/ResendVerificationOtp",
      RequestMethod.post,
      data: {
        "signupKey": signupKey,
      },
    );
    return response.data;
  }
}
