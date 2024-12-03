// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationHomePage extends StatefulWidget {
  @override
  _NotificationHomePageState createState() => _NotificationHomePageState();
}

class _NotificationHomePageState extends State<NotificationHomePage> {
    List<PendingNotificationRequest> _pendingNotifications = [];


  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  Future<void> _showInstantNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'Notification_id',
      'Notifications',
      channelDescription: 'My Test Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _notificationsPlugin.show(
      0,
      'Notification Title',
      'This is My Test Notification',
      platformChannelSpecifics,
    );
  }

  Future<void> _showScheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'scheduled_channel_id',
    'Scheduled Notifications',
    channelDescription: 'Channel for scheduled notifications',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      

  await _notificationsPlugin.zonedSchedule(
    1,
    'scheduled title',
    'scheduled body',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    platformChannelSpecifics,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _fetchPendingNotifications() async {
    final pendingNotifications =
        await _notificationsPlugin.pendingNotificationRequests();
    setState(() {
      _pendingNotifications = pendingNotifications;
    });
  }


  Future<void> _clearAllNotifications() async {
    await _notificationsPlugin.cancelAll();
    setState(() {
      _pendingNotifications = [];
    });
  } 
  @override
  void initState() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("America/Detroit"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: const Text('Local Notifications')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green)
              ),
              onPressed: _showInstantNotification,
              child: const Text('Show Instant Notification',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)
              ),
              onPressed: _showScheduleNotification,
              child:const Text('Show Schedule Notifications',style: TextStyle(color: Colors.white),),
            ),
            
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.orange)
              ),
              onPressed: _fetchPendingNotifications,
              child: const Text('Display Pending Notifications',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red)
              ),
              onPressed: _clearAllNotifications,
              child: const Text('Clear All Notifications',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            _pendingNotifications.isNotEmpty ? Expanded(
              child: ListView.builder(
                itemCount: _pendingNotifications.length,
                itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text("${_pendingNotifications[index].title}"),
                        Text("${_pendingNotifications[index].body}"),
                      ],
                    ),
                  );
                }),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
