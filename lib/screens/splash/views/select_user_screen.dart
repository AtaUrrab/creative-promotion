import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/references.dart';
import '../../../../core/widgets/button.dart';
import '../../admin/auth/login/login_screen.dart' as admin;
import '../../agent/auth/login/login_screen.dart' as agent;
import '../../warehouse/auth/sign_in/views/sign_in_view.dart' as warehouse;

class SelectUserScreen extends StatelessWidget {
  const SelectUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.logo,
                  width: Get.width * 0.5,
                ),
              ],
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: Get.width,
              child: AppButton(
                onTap: _admin,
                title: "Admin",
                color: Colors.black,
                titleStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: AppButton(
                onTap: _agend,
                title: "Agent",
                color: AppColor.red,
                titleStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width,
              child: AppButton(
                onTap: _warehouse,
                title: "Warehouse Manager",
                color: Colors.black,
                titleStyle: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _admin() {
    Get.to(() => const admin.LoginScreen());
  }

  _agend() {
    Get.to(() => const agent.LoginScreen());
  }

  _warehouse() {
    Get.to(() => const warehouse.SignInScreen());
  }
}
