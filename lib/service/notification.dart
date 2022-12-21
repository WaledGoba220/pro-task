import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pro_task/models/notification_model.dart';

Future<void> messageHandler(RemoteMessage message) async {
  Data notificationMessage = Data.fromJson(message.data);
  print('notification from background : ${notificationMessage.title}');
}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Data notificationMessage = Data.fromJson(message.data);
    print('notification from foreground : ${notificationMessage.title}');
  });
}

Future<void> sendNotification() async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  Dio dio = Dio();

  var token = await getDeviceToken();
  print('device token : $token');

  final data = {
    "data": {
      "message": "Accept Ride Request",
      "title": "This is Ride Request",
    },
    "to": token
  };

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = 'AAAAK9E6MMU:APA91bFZE7wJnO7hB3mzSscTeLafCCqMj7E7m5PoxHQmazra6PggJUZRZJLWI2xOcb8sF214Z1mWYKRJ35TK2Y5lhgo5TA9FGk1z9apEzfGkJSJcfuBVHYAcawFa36ie8yI5Zz21Jc-W';

  try {
    final response = await dio.post(postUrl, data: data);

    if (response.statusCode == 200) {
      print('Request Sent To Driver');
    } else {
      print('notification sending failed');
    }
  } catch (e) {
    print('exception $e');
  }
}

Future<String> getDeviceToken() async {
  return await FirebaseMessaging.instance.getToken();
}
