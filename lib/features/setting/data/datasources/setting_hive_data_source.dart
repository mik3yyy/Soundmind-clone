import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/core/error/exceptions.dart';

abstract class SettingHiveDataSource {
  Future<void> saveUserDetails({required Map<String, dynamic> userDetails});
  Future<Map<String, dynamic>> getUserDetails();
}

class SettingHiveDataSourceImpl extends SettingHiveDataSource {
  final Box _box;
  final String key = 'userDetailsKey';

  SettingHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> saveUserDetails(
      {required Map<String, dynamic> userDetails}) async {
    await _box.put(key, userDetails);
  }

  @override
  Future<Map<String, dynamic>> getUserDetails() async {
    var res = _box.get(key);
    if (res != null) {
      return Map<String, dynamic>.from(res);
    } else {
      throw CacheException(
        message: 'No cached user details found',
      );
    }
  }
}
