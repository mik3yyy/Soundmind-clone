import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/core/error/exceptions.dart';
import 'package:sound_mind/features/Security/presentation/blocs/Security_bloc.dart';

abstract class SecurityHiveDataSource {
  Future<void> setPin({required String pin});
  Future<bool> checkPin({required String pin});
  Future<bool> isPinSet();
  Future<void> clearPin();
}

class SecurityHiveDataSourceImpl extends SecurityHiveDataSource {
  final Box _box;

  SecurityHiveDataSourceImpl({required Box box}) : _box = box;

  String key = "securityBox";
  @override
  Future<bool> checkPin({required String pin}) async {
    try {
      String Opin = await _box.get(key);
      return pin == Opin;
    } on HiveError catch (e) {
      throw CacheException(message: "something went wrong");
    }
  }

  @override
  Future<void> setPin({required String pin}) async {
    try {
      await _box.put(key, pin);
    } on HiveError catch (e) {
      throw CacheException(message: "unable to set pin");
    }
  }

  @override
  Future<void> clearPin() async {
    try {
      await _box.delete(key);
    } on HiveError catch (e) {
      throw CacheException(message: "unable to clear");
    }
  }

  @override
  Future<bool> isPinSet() async {
    try {
      String? Opin = await _box.get(key, defaultValue: null);
      return Opin != null;
    } on HiveError catch (e) {
      throw CacheException(message: "something went wrong");
    }
  }
}
