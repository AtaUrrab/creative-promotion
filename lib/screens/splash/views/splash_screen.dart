import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/references.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SafeArea(
            child: Image.asset(
              Assets.logo,
              width: Get.width * 0.5,
            ),
          ),
        ));
  }
}
