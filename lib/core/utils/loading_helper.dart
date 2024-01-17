import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class LoadingHelper {
  static showLoading() {
    Get.dialog(
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetPlatform.isAndroid
                ? const CircularProgressIndicator(color: AppColor.red)
                : const CupertinoActivityIndicator(color: AppColor.red)
          ],
        ),
      ),
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.white.withOpacity(0.5),
    );
  }

  static hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
