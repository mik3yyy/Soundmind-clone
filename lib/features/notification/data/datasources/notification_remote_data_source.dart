import 'package:dio/dio.dart';
import 'package:sound_mind/core/utils/typedef.dart';

import '../../../../core/network/network.dart';

abstract class NotificationRemoteDataSource {
  Future<DataMap> getUserNotification();

  // Define abstract methods here
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  final Network _network;

  NotificationRemoteDataSourceImpl({required Network network})
      : _network = network;

  @override
  Future<DataMap> getUserNotification() async {
    // TODO: implement getUserNotification
    Response response = await _network.call(
      "/UserDashboard/GetUserNotifications",
      RequestMethod.get,
    );
    print(response.data);
    return response.data;
  }
}
