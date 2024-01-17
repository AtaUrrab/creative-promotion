import 'package:creativepromotion/screens/agent/auth/forget_password/forget_password_screen.dart';
import 'package:creativepromotion/screens/warehouse/auth/sign_up/views/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/utils/strings.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/textfield.dart';
import '../controllers/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    Assets.logo,
                    width: Get.width * 0.45,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Warehouse Manager",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  TextFieldWidget(
                    controller: controller.email,
                    hintText: AppString.email,
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
                  const SizedBox(height: 20),
                  GetBuilder<SignInController>(
                    builder: (_) {
                      return TextFieldWidget(
                          suffixIcon: IconButton(
                            icon: Icon(
                              !controller.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: !controller.obscurePassword
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            onPressed: controller.signinpasswordstatus,
                          ),
                          hintText: "Password",
                          obscureText: !controller.obscurePassword,
                          controller: controller.password,
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgetPasswordScreen());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AppColor.red,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  GetBuilder<SignInController>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: controller.isChecked,
                            activeColor: Colors.black,
                            tristate: true,
                            onChanged: (newValue) {
                              controller.isChecked = !controller.isChecked;
                              controller.update();
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
                  const SizedBox(height: 25),
                  SizedBox(
                    width: Get.width,
                    child: AppButton(
                      onTap: () => controller.login(context),
                      title: "Continue",
                      color: AppColor.red,
                      titleStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(children: [
                    Expanded(
                        child: Divider(
                      endIndent: 10,
                    )),
                    Text("OR"),
                    Expanded(child: Divider(indent: 10)),
                  ]),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.0, color: AppColor.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColor.red.withOpacity(0.05),
                      ),
                      onPressed: _registration,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registration() {
    Get.to(() => const SignUpScreen());
  }
}
