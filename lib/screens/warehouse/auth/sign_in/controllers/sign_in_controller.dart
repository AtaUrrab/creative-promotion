// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../models/notifications_model.dart';
import '../../../../../models/user_model.dart';
import '../../../main/screens/main_screen.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscurePassword = false;
  bool isChecked = false;
  final String notificationID = getRandomString(25);
  void login(BuildContext ctx) async {
    if (!formKey.currentState!.validate()) return;
    if (isChecked == false) {
      Get.snackbar(
          "Error", "Please Check mark Terms and Consitios and Privacy Policy");
      return;
    }
    final userCredential = await SignInService()
        .signInWithEmailAndPassword(email.text, password.text);
    _navigateUser(userCredential, ctx);
  }

  void google(BuildContext ctx) async {
    final UserCredential? userCredential =
        await SignInService().signInWithGoogle();
    _navigateUser(userCredential, ctx);
  }

  void facebook(BuildContext ctx) async {
    final userCredential = await SignInService().signInWithFacebook();
    _navigateUser(userCredential, ctx);
  }

  void signinpasswordstatus() {
    obscurePassword = !obscurePassword;
    update();
  }

  Future<void> _navigateUser(
      UserCredential? userCredential, BuildContext ctx) async {
    if (userCredential == null) return;
    Constant.user =
        await FirestoreService.getCurrentUser(userCredential.user!.uid);
    if (Constant.user == null) {
      Constant.user = await _createAccount(userCredential);
      await _createNotification(Constant.user!);
    }
    final currentDate = Timestamp.now();
    final restrictedDate = Constant.user!.restrictedToDate;
    if (currentDate.compareTo(restrictedDate) < 0) {
      Get.snackbar("Account Disabled",
          "Your Account has been Temporarly Disabled. You can't Login.");
      return;
    }
    if (Constant.user!.status != UserStatus.approved.name) {
      _verficationDialogBox(ctx);
      return;
    }
    if (Constant.user!.role == Role.manager.name) {
      Get.offAll(() => const MainScreen());
      return;
    }
    if (Constant.user!.role == Role.admin.name ||
        Constant.user!.role == Role.agent.name) {
      Get.snackbar("Messege", "only warehouse manager can login here");
      Constant.user = null;
      SignOutService().signOut();
      return;
    }
  }

  void _verficationDialogBox(BuildContext context) {
    showDialog<void>(
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
        role: user.role);
    await FirestoreService.createNotification(notification);
  }

  Future<UserModel> _createAccount(UserCredential credential) async {
    final user = UserModel(
      uid: credential.user!.uid,
      notificationID: notificationID,
      firstName: credential.user!.displayName!.split(" ").first,
      lastName: credential.user!.displayName!.split(" ").last,
      imgUrl: credential.user!.photoURL!,
      createdAt: Timestamp.now(),
      email: credential.user!.email!,
      area: "",
      phone: "",
      role: Role.manager.name,
      status: UserStatus.pending.name,
      snnNo: '',
      commision: 0.0,
      restrictedToDate: Timestamp.fromDate(DateTime(2022)),
    );
    await FirestoreService.createUser(user);
    return user;
  }
}
