import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/enums.dart';
import 'package:creativepromotion/models/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/helpers/helper_class.dart';
import '../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../core/services/firebase/database/firestore_storage.dart';
import '../../../../core/services/firebase/email/email_service.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../core/utils/functions.dart';
import '../../../../models/user_model.dart';

class RegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();

  File? img;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final area = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool obscurePassword = false;
  bool obscureConfirmPassword = false;
  bool isChecked = false;
  final String notificationID = getRandomString(25);

  void onTapImage(BuildContext context) async {
    XFile? dynamicImagePath =
        (await HelperClass().bottomSheetImagePicker(context));
    update();
    if (dynamicImagePath == null) {
      return;
    }
    img = File(XFile(dynamicImagePath.path).path);
    update();
  }

  createAccount(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (isChecked == false) {
      Get.snackbar(
          "Error", "Please Check mark Terms and Consitios and Privacy Policy");
      return;
    }
    String imgURL = '';

    final credentials = await SignUpService()
        .signUpWithEmailAndPassword(email.text.trim(), password.text);

    if (credentials == null) return;
    final userCredential = await SignInService()
        .signInWithEmailAndPassword(email.text.trim(), password.text);
    if (userCredential == null) return;
    if (img != null) {
      imgURL = await FirestoreStorage.uploadProfile(
          img!.path, userCredential.user!.uid);
    }
    final user = UserModel(
      uid: userCredential.user!.uid,
      notificationID: notificationID,
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      imgUrl: imgURL,
      createdAt: Timestamp.now(),
      email: email.text.trim(),
      role: Role.agent.name,
      status: UserStatus.pending.name,
      phone: phone.text.trim(),
      area: area.text.trim(),
      snnNo: "",
      commision: 0.0,
      restrictedToDate: Timestamp.fromDate(DateTime(2022)),
    );
    _createNotification(user);
    EmailService(
            email: user.email,
            name: "${user.firstName} ${user.lastName}",
            role: user.role)
        .newUser(user.createdAt);
    final isSuccess = await FirestoreService.createUser(user);
    if (!isSuccess) return;
    await _verficationDialogBox(Get.context!);
    Get.back();
  }

  void signinpasswordstatus() {
    obscurePassword = !obscurePassword;
    update();
  }

  void confirmpassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  Future<void> _verficationDialogBox(BuildContext context) async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Verification'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        '''Your account will be available to you within the next 24 hours after a thorough review and verification of the information provided.'''),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }

  Future<void> _createNotification(UserModel user) async {
    final notification = NotificationsModel(
      id: notificationID,
      uid: user.uid,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      imgUrl: user.imgUrl,
      status: "pending",
      createdAt: Timestamp.now(),
      role: user.role,
    );
    await FirestoreService.createNotification(notification);
  }
}
