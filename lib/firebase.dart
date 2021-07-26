import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> initFcm() async {

  messaging.getToken().then((token) {
    print("\n******\nFirebase Token $token\n******\n");
  });

  messaging.subscribeToTopic("all");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  if (Platform.isIOS) {
    messaging.requestPermission(sound: true, badge: true, alert: true);

    NotificationSettings settings = await messaging.requestPermission(
      sound: true,
      badge: true,
      alert: true
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }
}