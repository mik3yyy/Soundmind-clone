import 'package:flutter/material.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/notification/data/models/notification_model.dart';

abstract class NotificationRepository {
  // Define abstract methods here

  ResultFuture<List<NotificationModel>> getUserNotification();
}
