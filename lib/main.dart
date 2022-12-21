import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pro_task/screens/fingerprint_screen.dart';
import 'package:pro_task/service/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init(['en', 'ar']);
  FirebaseMessaging.onBackgroundMessage(messageHandler);
  firebaseMessagingListener();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: "Home",
        // home: NotificationFcmScreen(
        //   title: "Home",
        // ),
        home: FingerPrintScreen(),
      ),
    );
  }
}
