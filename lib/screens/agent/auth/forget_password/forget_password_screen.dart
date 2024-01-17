import 'package:creativepromotion/screens/agent/auth/forget_password/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/references.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.logo,
                  width: Get.width * 0.3,
                )
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              "Enter Your Email to  Recover your Password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
            Form(
              key: controller.formKey,
              child: TextFieldWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (!value.isEmail) {
                    return 'Please enter correct email';
                  }
                  return null;
                },
                controller: controller.email,
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "We have sent  password recover link to your email please verify",
              style: TextStyle(color: Color(0xFFC7C5C5)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppButton(
          onTap: controller.next,
          title: "Continue",
        ),
      )),
    );
  }
}
