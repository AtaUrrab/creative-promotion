import 'dart:developer';

import 'package:creativepromotion/core/utils/loading_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String someThingWentWrong = "Something went wrong. Try Again.";
}

class SignInService extends FirebaseAuthService {
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      LoadingHelper.showLoading();
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoadingHelper.hideLoading();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      LoadingHelper.hideLoading();
      Get.snackbar(e.code, e.message ?? someThingWentWrong);
    }
    return null;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      LoadingHelper.showLoading();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        LoadingHelper.hideLoading();
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredentials = await _auth.signInWithCredential(credential);
      LoadingHelper.hideLoading();
      return userCredentials;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? someThingWentWrong);
    }
    return null;
  }

  Future<UserCredential?> signInWithFacebook() async {
    UserCredential? userCredential;
    try {
      LoadingHelper.showLoading();

      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);
      }
      LoadingHelper.hideLoading();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? someThingWentWrong);
    }
    return null;
  }

  // signInWithTwitter() async {
  //   try {
  //     final twitterLogin = new TwitterLogin(
  //         apiKey: '<your consumer key>',
  //         apiSecretKey: ' <your consumer secret>',
  //         redirectURI: '<your_scheme>://');
  //     final authResult = await twitterLogin.login();
  //     final twitterAuthCredential = TwitterAuthProvider.credential(
  //       accessToken: authResult.authToken!,
  //       secret: authResult.authTokenSecret!,
  //     );
  //     return await FirebaseAuth.instance
  //         .signInWithCredential(twitterAuthCredential);
  //   } on FirebaseAuthException catch (e) {
  //     log(e.message.toString());
  //     Get.snackbar(e.code, e.message ?? someThingWentWrong);
  //   }
  // }
}

class SignUpService extends FirebaseAuthService {
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      LoadingHelper.showLoading();
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      LoadingHelper.hideLoading();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? someThingWentWrong);
    }
    return null;
  }
}

class SignOutService extends FirebaseAuthService {
  Future<bool> signOut() async {
    bool isSuccess = false;
    try {
      LoadingHelper.showLoading();
      await _auth.signOut();
      LoadingHelper.hideLoading();
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? someThingWentWrong);
    }
    return isSuccess;
  }
}

class ForgetPasswordService extends FirebaseAuthService {
  Future<bool> forgetPassword(String email) async {
    try {
      LoadingHelper.showLoading();
      await _auth.sendPasswordResetEmail(email: email);
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseAuthException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      Get.snackbar(e.code, e.message ?? someThingWentWrong);
      return false;
    }
  }
}
