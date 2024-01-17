import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/services/firebase/auth/auth.dart';
import 'package:creativepromotion/core/services/firebase/database/firestore_storage.dart';
import 'package:creativepromotion/core/services/firebase/email/email_service.dart';
import 'package:creativepromotion/models/notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/helpers/helper_class.dart';
import '../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../models/user_model.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  File? profileIMG;
  String warehouseIMG = "";
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final state = TextEditingController();
  final warehouseName = TextEditingController();
  final warehouseAddress = TextEditingController();
  final warehouseNo = TextEditingController();
  final warehouseSize = TextEditingController();
  bool obscurePassword = false;
  bool obscureConfirmPassword = false;
  bool isChecked = false;
  final String notificationID = getRandomString(25);

  void profileImage(BuildContext context) async {
    String? imagePath;
    imagePath = (await HelperClass().bottomSheetImagePicker(context));
    update();
    if (imagePath == null) {
      return;
    } else {
      profileIMG = File(imagePath);
      update();
    }
  }

  void warehouseImage(BuildContext context) async {
    XFile? dynamicImagePath =
        (await HelperClass().bottomSheetImagePicker(context));
    update();
    if (dynamicImagePath == null) {
      return;
    }
    warehouseIMG = dynamicImagePath.path;
    update();
  }

  void submit() async {
    if (!formKey.currentState!.validate()) return;
    if (isChecked == false) {
      Get.snackbar(
          "Error", "Please Check mark Terms and Consitios and Privacy Policy");
      return;
    }

    try {
      final credentials = await SignUpService()
          .signUpWithEmailAndPassword(email.text.trim(), password.text);
      if (credentials == null) return;
      final userCredential = await SignInService()
          .signInWithEmailAndPassword(email.text.trim(), password.text);
      if (userCredential == null) return;
      String imgUrl = "";
      if (profileIMG != null) {
        imgUrl = await FirestoreStorage.uploadProfile(
            profileIMG!.path, userCredential.user!.uid);
      }
      if (warehouseIMG.isNotEmpty) {
        warehouseIMG = await FirestoreStorage.upload(
            filePath: warehouseIMG,
            path: "warehouse/${userCredential.user!.uid}");
      }
      final user = UserModel(
        uid: userCredential.user!.uid,
        notificationID: notificationID,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        imgUrl: imgUrl,
        createdAt: Timestamp.now(),
        email: email.text.trim(),
        role: Role.manager.name,
        status: UserStatus.pending.name,
        phone: phone.text,
        area: "",
        snnNo: "",
        commision: 0.0,
        restrictedToDate: Timestamp.fromDate(DateTime(2022)),
        manager: WarehouseDetails(
          address: warehouseAddress.text.trim(),
          name: warehouseName.text.trim(),
          number: phone.text.trim(),
          size: int.parse(warehouseSize.text.trim()),
          state: state.text.trim(),
          storeImgUrl: warehouseIMG,
        ),
      );
      EmailService(
        email: user.email,
        name: "${user.firstName} ${user.lastName}",
        role: user.role,
      ).newUser(user.createdAt);
      _createNotification(user);
      final isSuccess = await FirestoreService.createUser(user);
      if (!isSuccess) return;
      await _verficationDialogBox(Get.context!);
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }

  void signinpasswordstatus() {
    obscurePassword = !obscurePassword;
    update();
  }

  void confirmpasswordstatus() {
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
                        '''We'll review your info and if we can confirm it, you'll be able to access your account within approximately 24 hours.'''),
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
