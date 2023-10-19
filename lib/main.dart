import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tag_app/data/data_bindings.dart';
import 'package:tag_app/utils/const.dart';
import 'package:tag_app/utils/localization_page.dart';
import 'package:tag_app/view/chat_screen.dart';
import 'package:tag_app/view/dashboard.dart';
import 'package:tag_app/view/drawer_screen.dart';
import 'package:tag_app/view/home_screen.dart';
import 'package:tag_app/view/signin_screen.dart';
import 'package:tag_app/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataBindings();
  Firebase.initializeApp();
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.openBox(cGunBoxKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        debugShowCheckedModeBanner: false,
        title: 'Track A Gun',
        getPages: [
          GetPage(
            name: "/",
            page: () => const SplashScreen(),
          )
        ]);
  }
}
