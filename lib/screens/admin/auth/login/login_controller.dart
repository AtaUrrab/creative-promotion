import 'package:creativepromotion/core/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../main/home/home_screen.dart' as admin;

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscurePassword = false;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (isChecked == false) {
      Get.snackbar(
          "Error", "Please Check mark Terms and Consitios and Privacy Policy");
      return;
    }
    final userCredential = await SignInService()
        .signInWithEmailAndPassword(email.text, password.text);
    if (userCredential != null) {
      Constant.user =
          await FirestoreService.getCurrentUser(userCredential.user!.uid);
      if (Constant.user!.role == Role.admin.name) {
        Get.offAll(() => const admin.HomeScreen());
      }
      return;
    }
  }

  void signinpasswordstatus() {
    obscurePassword = !obscurePassword;
    update();
  }
}
