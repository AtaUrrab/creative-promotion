import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';

class ForgetPasswordController extends GetxController {
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void next() async {
    if (!formKey.currentState!.validate()) return;
    Get.back();
    final isSuccess =
        await ForgetPasswordService().forgetPassword(email.text.trim());
    if (isSuccess) {
      _snackBar();
    }
  }
}

_snackBar() {
  Get.snackbar("Check your email",
      "You'll receive an email with a link to reset your password. Please click on the link within 24 hours to complete the password reset process.");
}
