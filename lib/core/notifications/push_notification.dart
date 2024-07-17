import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sound_mind/core/notifications/notification_service.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await _fcm.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification tap event
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    // Handle background notification
  }

  Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  void subscribeToTopic(String topic) {
    _fcm.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    _fcm.unsubscribeFromTopic(topic);
  }
}

