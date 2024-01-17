import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/constant/constant.dart';
import '../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../core/utils/loading_helper.dart';
import '../core/utils/references.dart';
import '../core/widgets/button.dart';
import '../core/widgets/dialog_box.dart';
import '../core/widgets/textfield.dart';
import 'splash/views/select_user_screen.dart';

class DeleteUserAccount extends StatelessWidget {
  const DeleteUserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountDeleteController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetBuilder<AccountDeleteController>(
              builder: (_) {
                return Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.logo,
                            width: Get.width * 0.5,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Delete User Account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(),
                        ),
                        child: Row(
                          children: [
                            //Temporary Delete Button
                            DeleteOptionsWidget(
                              onTap: () {
                                controller.isClicked = false;
                                controller.update();
                              },
                              color: controller.isClicked == false
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0)),
                              text: "Temporary",
                              textColor: controller.isClicked == false
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            //Permanent Delete Button
                            DeleteOptionsWidget(
                              onTap: () {
                                controller.isClicked = true;
                                controller.update();
                              },
                              color: controller.isClicked == true
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0)),
                              text: "Permanent",
                              textColor: controller.isClicked == true
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),
                      controller.isClicked == false
                          //Temporary Delete Widget
                          ? Column(
                              children: [
                                const Text(
                                  "Enter the Re-Joining Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 15),
                                TextFieldWidget(
                                  controller: controller.dateText,
                                  hintText: "Day and Date",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Plese Fill this field";
                                    }
                                    return null;
                                  },
                                  onTap: () => controller.datePick(context),
                                ),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: Get.width,
                                  child: AppButton(
                                    onTap: () async {
                                      if (!controller.formKey.currentState!
                                          .validate()) {
                                        return;
                                      }
                                      controller.accountDisableDialog(context);
                                    },
                                    title: "Temporary Disable",
                                    titleStyle:
                                        const TextStyle(color: Colors.white),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )
                          //Permanent Delete Widget
                          : Column(
                              children: [
                                const Text(
                                  "Enter your details to delete your account permanently.",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                TextFieldWidget(
                                  onTap: null,
                                  controller: TextEditingController(
                                      text: Constant.user!.email),
                                  hintText: "Email",
                                  readyOnly: true,
                                  // enabled: false,
                                  // fillColor: Colors.black,
                                ),
                                const SizedBox(height: 12),
                                TextFieldWidget(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        !controller.obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: !controller.obscurePassword
                                            ? Colors.grey
                                            : Colors.blue,
                                      ),
                                      onPressed: () {
                                        controller.obscurePassword =
                                            !controller.obscurePassword;
                                        controller.update();
                                      },
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
                                    }),
                                const SizedBox(height: 15),
                                SizedBox(
                                  width: Get.width,
                                  child: AppButton(
                                    onTap: () {
                                      if (!controller.formKey.currentState!
                                          .validate()) {
                                        return;
                                      }
                                      controller.deleteAccountDialog(context);
                                    },
                                    title: "Permanent Delete",
                                    titleStyle:
                                        const TextStyle(color: Colors.white),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteOptionsWidget extends StatelessWidget {
  final Color color;
  final BorderRadius borderRadius;
  final String text;
  final Color textColor;
  final void Function()? onTap;

  const DeleteOptionsWidget({
    super.key,
    required this.color,
    required this.borderRadius,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: color, borderRadius: borderRadius),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )),
        ),
      ),
    );
  }
}

class AccountDeleteController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscurePassword = false;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isClicked = false;
  DateTime? dateTime;
  final dateText = TextEditingController();

  //*********************** Permanent Delete Account Dialog */

  deleteAccountDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialog(
            isCrossDisabled: true,
            title: "Permanently Account Delete",
            description: "Are you sure you want to delete your account?",
            firstButtonText: "Cancel",
            secondButtonText: "Delete",
            firstCallback: () {
              Navigator.of(context).pop();
            },
            secondCallback: () {
              permanentDeleteAccount();
            },
          );
        });
  }

  //*********************** User Account Delete Method */
  permanentDeleteAccount() async {
    LoadingHelper.showLoading();
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      AuthCredential userCredential = EmailAuthProvider.credential(
          email: Constant.user!.email, password: password.text);
      await currentUser
          .reauthenticateWithCredential(userCredential)
          .then((value) async {
        String userID = value.user!.uid;
        await firebaseFirestore
            .collection("notifications")
            .doc(Constant.user!.notificationID)
            .delete();
        await firebaseFirestore.collection("users").doc(userID).delete();
        await value.user!.delete();
        LoadingHelper.hideLoading();
        Get.snackbar('Success', "Your account has been removed permanently");
        Get.offAll(() => const SelectUserScreen());
        Constant.user = null;
      }).onError((error, stackTrace) {
        LoadingHelper.hideLoading();
        Get.back();
        Get.snackbar('Wrong Password', "Please check your Password");
      });
    }
  }
  //*********************** Temporary Account Disable Dialog */

  accountDisableDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialog(
            isCrossDisabled: true,
            title: "Temporary Disable Account",
            description: "Are you sure you want to disable your account?",
            firstButtonText: "Cancel",
            secondButtonText: "Delete",
            firstCallback: () {
              Navigator.of(context).pop();
            },
            secondCallback: () {
              disableAccountMethod();
            },
          );
        });
  }

  //*********************** Temporary Account Disable Method */
  disableAccountMethod() async {
    LoadingHelper.showLoading();
    User? currentUser = auth.currentUser;
    if (dateTime == null) {
      Get.snackbar('DateTime Error', "Please chose a date");
    }
    if (currentUser != null) {
      try {
        await firebaseFirestore.collection("users").doc(currentUser.uid).update(
          {"restrictedToDate": dateTime},
        );
        // LoadingHelper.hideLoading();
        // Constant.user = null;
        // Get.offAll(() => const SelectUserScreen());

        Constant.user = null;
        await SignOutService().signOut();
        Get.snackbar('Success', "Your account has been temporary disabled ");
        Get.offAll(() => const SelectUserScreen());
      } catch (error) {
        LoadingHelper.hideLoading();
        log("Error: $error");
      }
    } else {
      LoadingHelper.hideLoading();
      return;
    }
  }

//*********************** Date Picker Method */
  datePick(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (datePicker == null) return;
    TimeOfDay? time;
    if (context.mounted) {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }
    if (time == null) return;
    datePicker.copyWith(minute: time.minute, hour: time.hour);
    dateText.text = DateFormat("dd/MM/yyyy-h:m a").format(datePicker);
    dateTime = datePicker;
    final currentDate = DateTime.now();
    if (currentDate.compareTo(dateTime!) > 0) {
      Get.snackbar("Date Error", "Please Select Next Date");
      dateText.text = '';
      dateTime = null;
      return;
    }
  }
}
