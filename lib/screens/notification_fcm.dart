import 'package:flutter/material.dart';
import 'package:pro_task/service/notification.dart';

class NotificationFcmScreen extends StatefulWidget {
  const NotificationFcmScreen({Key key, @required this.title})
      : super(key: key);

  final String title;
  @override
  State<NotificationFcmScreen> createState() => _NotificationFcmScreenState();
}

class _NotificationFcmScreenState extends State<NotificationFcmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Notifications',),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          sendNotification();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}