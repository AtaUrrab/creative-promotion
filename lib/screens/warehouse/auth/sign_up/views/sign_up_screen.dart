import 'package:creativepromotion/screens/warehouse/auth/sign_up/controllers/sign_up_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/functions.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/cards.dart';
import '../../../../../core/widgets/others.dart';
import '../../../../../core/widgets/textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<SignUpController>(
                    builder: (_) => CircleImage(
                      isRegistration: true,
                      heading: "",
                      imgAsset: controller.profileIMG,
                      onTap: () => controller.profileImage(context),
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Upload Your Image",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: controller.firstName,
                    hintText: "First Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.lastName,
                    hintText: "Last Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.email,
                    hintText: "Email Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.isEmail) {
                        return 'Please enter valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.phone,
                    hintText: "Phone No:",
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.warehouseName,
                    hintText: "Warehouse Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.warehouseAddress,
                    hintText: "Warehouse Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.warehouseNo,
                    hintText: "Warehouse No:",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.isPhoneNumber) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.warehouseSize,
                    hintText: "Warehouse Size (Sq Feet)",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (!value.isNum) {
                        return 'Please enter valid size';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldWidget(
                    controller: controller.state,
                    hintText: "State",
                  ),
                  const SizedBox(height: 18),
                  GetBuilder<SignUpController>(
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
                  const SizedBox(height: 18),
                  GetBuilder<SignUpController>(
                    builder: (_) {
                      return TextFieldWidget(
                          suffixIcon: IconButton(
                            icon: Icon(
                              !controller.obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: !controller.obscureConfirmPassword
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                            onPressed: controller.confirmpasswordstatus,
                          ),
                          hintText: " Confirm Password",
                          obscureText: !controller.obscureConfirmPassword,
                          controller: controller.confirmPassword,
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
                  GetBuilder<SignUpController>(
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
                  const SizedBox(height: 18),
                  GetBuilder<SignUpController>(
                    builder: (_) => SizedBox(
                      width: double.infinity,
                      child: AttachImageWidget(
                        imgAssetPath: controller.warehouseIMG,
                        onTap: () => controller.warehouseImage(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Upload Warehouse Front Picture",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onTap: controller.submit,
                      title: "Submit",
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
