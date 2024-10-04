import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/notification_listener.dart';
import 'package:sound_mind/core/error/failures.dart';
import 'package:sound_mind/core/network/network.dart';

import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/notification/data/models/notification_model.dart';

import '../datasources/notification_hive_data_source.dart';
import '../datasources/notification_remote_data_source.dart';
import '../../domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationHiveDataSource hiveDataSource;
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({
    required this.hiveDataSource,
    required this.remoteDataSource,
  });

  @override
  ResultFuture<List<NotificationModel>> getUserNotification() async {
    try {
      var result = await remoteDataSource.getUserNotification();

      List<NotificationModel> notifications = (result['data']! as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList(); //as List<NotificationModel>;
      return Right(notifications);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  // Implement repository methods here, using hiveDataSource and remoteDataSource
}
