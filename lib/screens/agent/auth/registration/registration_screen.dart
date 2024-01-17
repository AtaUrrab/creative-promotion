import 'package:creativepromotion/screens/agent/auth/registration/registration_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/others.dart';
import '../../../../core/widgets/textfield.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegistrationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: registerController.formKey,
            child: Column(children: [
              GetBuilder<RegistrationController>(
                builder: (_) {
                  return CircleImage(
                    onTap: () => registerController.onTapImage(context),
                    isRegistration: true,
                    heading: "",
                    imgAsset: registerController.img,
                    size: 100,
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text("Upload Your Image"),
              const SizedBox(height: 20),
              TextFieldWidget(
                controller: registerController.firstName,
                hintText: "First Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: registerController.lastName,
                hintText: "Last Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: registerController.area,
                hintText: "Area",
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: registerController.email,
                hintText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: registerController.phone,
                hintText: "Phone",
              ),
              const SizedBox(height: 10),
              // TextFieldWidget(
              //   controller: registerController.ssnNo,
              //   hintText: "SSN No:",
              // ),
              // const SizedBox(height: 10),
              GetBuilder<RegistrationController>(
                builder: (_) {
                  return TextFieldWidget(
                      suffixIcon: IconButton(
                        icon: Icon(
                          !registerController.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: !registerController.obscurePassword
                              ? Colors.grey
                              : Colors.blue,
                        ),
                        onPressed: registerController.signinpasswordstatus,
                      ),
                      hintText: "Password",
                      obscureText: !registerController.obscurePassword,
                      controller: registerController.password,
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
              const SizedBox(height: 10),
              GetBuilder<RegistrationController>(
                builder: (_) {
                  return TextFieldWidget(
                      suffixIcon: IconButton(
                        icon: Icon(
                          !registerController.obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: !registerController.obscureConfirmPassword
                              ? Colors.grey
                              : Colors.blue,
                        ),
                        onPressed: registerController.confirmpassword,
                      ),
                      hintText: "Confirm Password",
                      obscureText: !registerController.obscureConfirmPassword,
                      controller: registerController.confirmPassword,
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
              GetBuilder<RegistrationController>(
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: registerController.isChecked,
                        activeColor: Colors.black,
                        tristate: true,
                        onChanged: (newValue) {
                          registerController.isChecked =
                              !registerController.isChecked;
                          registerController.update();
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
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width,
                child: AppButton(
                  onTap: () => registerController.createAccount(context),
                  title: "Submit",
                  color: AppColor.red,
                  titleStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
