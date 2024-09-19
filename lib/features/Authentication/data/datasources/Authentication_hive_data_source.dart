import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/features/Authentication/data/models/User_model.dart';

abstract class AuthenticationHiveDataSource {
  Future<void> saveUser({required UserModel userModel});
  Future<void> deleteUser();
  Future<UserModel> getUser();
}

class AuthenticationHiveDataSourceImpl extends AuthenticationHiveDataSource {
  String key = 'userKey';
  final Box _box;

  AuthenticationHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> deleteUser() async {
    await _box.delete(key);
  }

  @override
  Future<void> saveUser({required UserModel userModel}) async {
    await _box.put(key, userModel.toMap());
  }

  @override
  Future<UserModel> getUser() async {
    // TODO: implement getUser
    var res = _box.get(key);
    print(res);
    return UserModel.fromMap(res);
  }
}
