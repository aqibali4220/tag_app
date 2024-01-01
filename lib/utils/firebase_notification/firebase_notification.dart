import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../controllers/general_controller.dart';
import '../const.dart';
import '../singleton.dart';

class FirebaseNotifications {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static String? deviceToken;
  Map<String, dynamic>? data;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  static FirebaseNotifications get instance => FirebaseNotifications();

  Future<String?> getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        deviceToken = token;
        Get.find<GeneralController>().gunBox.put(cDvToken, token);


        print("Dv token $deviceToken");
      }
    }).catchError((onError) {
      print("the error is $onError");
    });
    return deviceToken;
  }

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print('Handling a background message $body');
  }

  Future _selectNotification(String? payload) async {}

  Future initLocalNotification() async {
    if (Platform.isIOS) {
      // set iOS Local notification.
      print("Inside ios");
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
          );
    } else {
      var initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = DarwinInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
         );
    }
  }

  Future navigationOnFcm() async {
    try {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission firebase notifications');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
      // onMessage is called in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification!.android;
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          // description
          importance: Importance.max,
        );
        void pushShowNotification(int code, String title, String message) {
          _flutterLocalNotificationsPlugin.show(
            code,
            title,
            message,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  //      one that already exists in sigitechnologies app.
                  icon: 'launch_background',
                ),
                iOS:
                const DarwinNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )

            ),
          );
        }

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  //      one that already exists in sigitechnologies app.
                  icon: 'launch_background',
                ),
                iOS: const DarwinNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )),
          );
        }

        pushShowNotification(message.notification.hashCode,
            message.notification!.title!, message.notification!.body!);
        // if(GetUtils.isCaseInsensitiveContains(message.notification!.title!, "Request")){
        if (message.notification!.title == "chat messages") {
          data = message.data;
          pushShowNotification(message.notification.hashCode,
              message.notification!.title!, message.notification!.body!);
        }
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification!.android;
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          // description
          importance: Importance.max,
        );
        void pushShowNotification(int code, String title, String message) {
          _flutterLocalNotificationsPlugin.show(
            code,
            title,
            message,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  //      one that already exists in sigitechnologies app.
                  icon: 'launch_background',
                ),
                iOS: const DarwinNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )),
          );
        }

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  //      one that already exists in sigitechnologies app.
                  icon: 'launch_background',
                ),
                iOS: const DarwinNotificationDetails(
                  presentSound: true,
                  presentAlert: true,
                )),
          );
        }
        pushShowNotification(message.notification.hashCode,
            message.notification!.title!, message.notification!.body!);
        Get.log("message data:${message.data}");
      });

      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {}
        // This gets called 4 times, every time gets called when app is restarted or I navigate back using pushReplacement()
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
