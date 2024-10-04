import 'package:dartz/dartz.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/features/notification/data/models/notification_model.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationData
    extends UsecaseWithoutParams<List<NotificationModel>> {
  final NotificationRepository repository;

  GetNotificationData({required this.repository});

  @override
  ResultFuture<List<NotificationModel>> call() =>
      repository.getUserNotification();

  // Implement call method here
}
