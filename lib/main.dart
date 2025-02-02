import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_lab/core/utils/my_color.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_lab/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_lab/core/helper/shared_preference_helper.dart';
import 'package:quiz_lab/core/route/route.dart';
import 'package:quiz_lab/core/utils/messages.dart';
import 'package:quiz_lab/core/utils/my_strings.dart';
import 'package:quiz_lab/data/controller/localization/localization_controller.dart';
import 'package:quiz_lab/push_notification_service.dart';
import 'core/di_service/di_services.dart' as di_service;
import 'core/utils/util.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  sharedPreferences.setBool(SharedPreferenceHelper.hasNewNotificationKey, true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di_service.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await PushNotificationService().setupInteractedMessage();

  HttpOverrides.global = MyHttpOverrides();

  MyUtils.allScreen();

  runApp(MyApp(languages: languages));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizeController) => GetMaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: MyColor.scaffoldBackgroundColor, appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light))),
        title: MyStrings.appName.tr,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: RouteHelper.splashScreen,
        navigatorKey: Get.key,
        getPages: RouteHelper().routes,
        locale: localizeController.locale,
        translations: Messages(languages: widget.languages),
        fallbackLocale: Locale(localizeController.locale.languageCode, localizeController.locale.countryCode),
      ),
    );
  }
}
