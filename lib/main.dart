import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moralar_widgets/models/answer_adapter.dart';
import 'package:moralar_widgets/models/description_adapter.dart';
import 'package:moralar_widgets/models/question_response_adapter.dart';
import 'package:moralar_widgets/models/quiz_adapter.dart';
import 'package:moralar_widgets/models/quiz_details_adapter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'app/routes/app_pages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initFirebaseMessaging() async {
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final storage = GetStorage();

  // Request permission for iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // Get the token for this device
  String? token = await messaging.getToken();
  storage.write('deviceId', token);

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a message while in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(documentDirectory.path)
    ..registerAdapter(QuizDetailsAdapter())
    ..registerAdapter(QuestionResponseAdapter())
    ..registerAdapter(DescriptionAdapter())
    ..registerAdapter(QuizAdapter())
    ..registerAdapter(AnswerAdapter());

  await MoralarWidgets.initialize(
    userType: UserType.family,
  );

  runApp(
    GetMaterialApp(
      title: "Moralar - Usuário",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      navigatorKey: navigatorKey,
    ),
  );

  // Access the context after the app is built
  final context = navigatorKey.currentContext;
  if (context != null) {
    await initFirebaseMessaging();
  }
}