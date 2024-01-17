import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../core/constant/enums.dart';
import '../../../core/database/shared_preferences.dart';
import '../../admin/main/home/home_screen.dart' as admin;
import '../../agent/main/add_store/views/add_screen.dart' as agent;
import '../../warehouse/main/screens/main_screen.dart' as warehouse;
import '../views/select_user_screen.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final LocalAuthentication auth;
  bool supportState = false;

  @override
  void onInit() {
    awaitFunc();
    super.onInit();
  }

  awaitFunc() async {
    await localAuthFunc();
    await _checkUser();
  }

  localAuthFunc() async {
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((value) {
      supportState = value;
      update();
    });
  }

  Future<void> _checkUser() async {
    await LocalData.initSharedPreferences();
    if (_auth.currentUser == null) {
      Constant.user = null;
      Get.offAll(() => const SelectUserScreen());
      return;
    }
    Constant.user =
        await FirestoreService.getCurrentUser(_auth.currentUser!.uid);
    if (Constant.user == null) {
      SignOutService().signOut();
      Get.offAll(() => const SelectUserScreen());
      return;
    }

    if (Constant.user != null) {
      await biometricauthfunc();
    }
  }

  Future<void> biometricauthfunc() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Loign with Biometric",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      if (authenticated == true) {
        if (Constant.user!.role == Role.admin.name) {
          Get.offAll(() => const admin.HomeScreen());
          return;
        }
        if (Constant.user!.role == Role.agent.name) {
          Get.offAll(() => const agent.AddScreen());
          return;
        }
        if (Constant.user!.role == Role.manager.name) {
          Get.offAll(() => const warehouse.MainScreen());
          return;
        }
      } else {
        return;
      }
    } on PlatformException catch (e) {
      showOkAlertDialog(
          context: Get.context!,
          title: "PlatformException Error",
          message: "$e");
    }
  }
}
