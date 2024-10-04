part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationData extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationData({required this.notifications});
}

class NotificationFailure extends NotificationState {
  final String message;

  NotificationFailure({required this.message});
}
