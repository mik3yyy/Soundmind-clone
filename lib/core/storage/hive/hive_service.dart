import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() => _instance;

  HiveService._internal();

  Future<void> init() async {
    await Hive.initFlutter();
    // Register adapters here
  }

  Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }

  Future<void> deleteBox(String boxName) async {
    await Hive.deleteBoxFromDisk(boxName);
  }
}
