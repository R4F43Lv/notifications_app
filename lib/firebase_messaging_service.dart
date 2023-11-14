import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_firebase_push/notification_service.dart';
import 'package:test_firebase_push/routes.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    // se o app estiver aberto ou em 2° plano
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessenge();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('===============TOKEN=====================\n$token\n=================================');
  }

  _onMessenge() async {
    // em 1° plano
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if(notification != null && android != null){
        _notificationService.showNotification(
          CustomNotification(
            id: android.hashCode, 
            title: notification.title!, 
            body: notification.body!, 
            payload: message.data['route'] ?? '',
          )
        );
      }
    });
  }

  _onMessengeOpenedApp() {
    // em 2° plano
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message){
    final String route = message.data['route'] ?? '';
    if(route.isNotEmpty){
      Routes.navigatorKey.currentState?.pushNamed(route);
    }
  }
}