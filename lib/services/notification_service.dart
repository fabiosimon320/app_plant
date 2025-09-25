import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidInit);

    await _flutterLocalNotificationsPlugin.initialize(initSettings);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Rome'));
  }

  Future<bool> requestPermissions() async {
    if(Platform.isAndroid) {
      if(await Permission.notification.request().isGranted) {
        return true;
      }else{
        return false;
      }
    }
    return true;
  }

  Future<void> showWaterReminder() async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'notificapiante',
      'Annaffiare piante',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      'Promemoria piante',
      'Ricordati di annaffiare le tue piante oggi!',
      platformDetails,
    );
  }

}