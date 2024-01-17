import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/references.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/textfield.dart';
import '../../../admin/auth/login/login_controller.dart' as admin;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(admin.LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: loginController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.logo,
                        width: Get.width * 0.5,
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  const Text(
                    "Admin Login",
                    style: TextStyle(
                        color: AppColor.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 36),
                  TextFieldWidget(
                    controller: loginController.email,
                    hintText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.isEmail) {
                        return 'Please enter correct email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  GetBuilder<admin.LoginController>(
                    builder: (_) {
                      return TextFieldWidget(
                          suffixIcon: IconButton(
                            icon: Icon(
                              !loginController.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: !loginController.obscurePassword
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            onPressed: loginController.signinpasswordstatus,
                          ),
                          hintText: "Password",
                          obscureText: !loginController.obscurePassword,
                          controller: loginController.password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Plese Enter Your Password Here";
                            }
                            if (value.length < 8) {
                              return "Please Enter Password with 8 Characters";
                            }

                            return null;
                          });
                    },
                  ),
                  const SizedBox(height: 15),
                  GetBuilder<admin.LoginController>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: loginController.isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newValue) {
                              loginController.isChecked =
                                  !loginController.isChecked;
                              loginController.update();
                            },
                          ),
                          Flexible(
                            child: RichText(
                                text: TextSpan(
                                    text: 'I agree to the ',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms and conditions',
                                    style: const TextStyle(
                                        color: Colors.blueAccent, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => launchPrivacyPolicyURL(),
                                  ),
                                  const TextSpan(
                                      text: ' and',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14)),
                                  TextSpan(
                                    text: ' Privacy Policy',
                                    style: const TextStyle(
                                        color: Colors.blueAccent, fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => launchPrivacyPolicyURL(),
                                  )
                                ])),
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: Get.width,
                    child: AppButton(
                      onTap: () => loginController.login(),
                      title: AppString.login,
                      titleStyle: const TextStyle(color: Colors.white),
                      color: AppColor.red,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
