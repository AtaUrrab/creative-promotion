import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'screens/splash/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme,
        home: const SplashScreen(),
      ),
    );
  }

  final _theme = ThemeData(
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        )),
  );
}
