import 'package:hive_flutter/hive_flutter.dart';
import 'package:sound_mind/core/error/exceptions.dart';

abstract class AppointmentHiveDataSource {
  Future<void> cacheAppointments(
      {required List<Map<String, dynamic>> appointments});
  Future<List<Map<String, dynamic>>> getCachedAppointments();
}

class AppointmentHiveDataSourceImpl extends AppointmentHiveDataSource {
  final Box _box;
  final String key = 'appointmentCache';

  AppointmentHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> cacheAppointments(
      {required List<Map<String, dynamic>> appointments}) async {
    await _box.put(key, appointments);
  }

  @override
  Future<List<Map<String, dynamic>>> getCachedAppointments() async {
    var res = _box.get(key);
    if (res != null) {
      return List<Map<String, dynamic>>.from(res);
    } else {
      throw CacheException(message: 'No cached appointments found');
    }
  }
}
