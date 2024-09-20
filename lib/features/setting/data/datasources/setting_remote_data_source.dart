import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:sound_mind/core/network/network.dart';
import 'package:sound_mind/core/utils/typedef.dart';

abstract class SettingRemoteDataSource {
  Future<DataMap> getUserDetails();
  Future<DataMap> updateUserDetails({
    required String firstName,
    required String lastName,
    required String email,
  });
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}

class SettingRemoteDataSourceImpl extends SettingRemoteDataSource {
  final Network _network;

  SettingRemoteDataSourceImpl({required Network network}) : _network = network;

  @override
  Future<DataMap> getUserDetails() async {
    Response response = await _network.call(
      "/api/Settings/GetUserDetails",
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<DataMap> updateUserDetails({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    Response response = await _network.call(
      "/api/Settings/UpdateUserDetails",
      RequestMethod.patch,
      data: json.encode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
      }),
    );
    return response.data;
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _network.call(
      "/api/Settings/ChangePassword",
      RequestMethod.patch,
      data: json.encode({
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      }),
    );
  }
}
