import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/notification/data/models/notification_model.dart';
import '../../domain/usecases/get_notification_data.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationData getNotificationData;

  NotificationBloc({required this.getNotificationData})
      : super(NotificationInitial()) {
    on<GetNotificationsEvent>(getUserNotification);
  }
  getUserNotification(GetNotificationsEvent event, Emitter emit) async {
    emit(NotificationLoading());
    var result = await getNotificationData.call();

    result.fold((fail) {
      emit(NotificationFailure(message: fail.message));
    }, (notifications) {
      emit(NotificationData(notifications: notifications));
    });
  }
}
