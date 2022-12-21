import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    localNotification = FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
        "channelId", "Local Notification",
        importance: Importance.high);

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    await localNotification.show(0, "Notification", "The Body Of Notification ",
        generalNotificationDetails);
  }

  bool iconBool = false;
  IconData iconLight = Icons.wb_sunny;
  IconData iconDark = Icons.nights_stay;

  ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
  );

  ThemeData darkTheme = ThemeData(
    primaryColor: Colors.red,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: iconBool ? Colors.grey.shade900 : Colors.white,
        appBar: AppBar(
          backgroundColor: iconBool ? Colors.grey.shade900 : Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  iconBool = !iconBool;
                });
              },
              icon: Icon(iconBool ? iconDark : iconLight),
              color: iconBool ? Colors.white : Colors.black,
            ),
          ],
        ),
        body: Center(
          child: Text(
            "Click This Button Click To Recieve a Notification ",
            style: TextStyle(
              color: iconBool ? Colors.white : Colors.black,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showNotification,
          child: const Icon(Icons.notifications),
        ),
      ),
    );
  }
}
