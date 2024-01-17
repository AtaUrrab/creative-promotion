import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/screens/admin/main/home/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/controllers/user_controller.dart';
import '../../../../core/services/firebase/database/firestore_storage.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../core/utils/loading_helper.dart';
import '../../../../core/widgets/native_action_sheet.dart';
import '../../../../models/user_model.dart';
import '../home/home_controller.dart';

class AdminProfileController extends GetxController {
  final firstName = TextEditingController(text: Constant.user?.firstName);
  final lastName = TextEditingController(text: Constant.user?.lastName);
  File? profileRef;
  final ImagePicker _imagePicker = ImagePicker();

  //********************** Image Picker Method */
  _pickImage(ImageSource source) async {
    try {
      LoadingHelper.showLoading();
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      final File imageFile = File(pickedFile!.path);
      LoadingHelper.hideLoading();
      update();
      return imageFile;
    } catch (e) {
      LoadingHelper.hideLoading();
      return null;
    }
  }

  //********************** Bottom Sheet Method */
  onTapProfileImage(BuildContext context) async {
    await showAdaptiveActionSheet(
      context: context,
      title: const Text('Profile photo'),
      androidBorderRadius: 30,
      actions: [
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: () async {
              profileRef = await _pickImage(ImageSource.gallery);
              Get.back();
            }),
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: () async {
              profileRef = await _pickImage(ImageSource.camera);
              Get.back();
            }),
        BottomSheetAction(
          title: const Text('Remove Image'),
          onPressed: () => profileImageDelete(),
        ),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
    update();
  }

//*********************** Image Delete Function */
  profileImageDelete() async {
    if (Constant.user!.imgUrl.isEmpty && Constant.user!.imgUrl == "") {
      Get.back();
      return;
    }
    LoadingHelper.showLoading();
    await FirebaseStorage.instance.refFromURL(Constant.user!.imgUrl).delete();
    UserModel? user = Constant.user?.copyWith(imgUrl: null);
    Constant.user = user;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Constant.user!.uid)
        .update(
      {"imgUrl": null},
    );
    update();
    final controller = Get.put(UserController());
    controller.updateUserState(user!);
    final homeController = Get.put(HomeController());
    homeController.update();
    LoadingHelper.hideLoading();
    Get.off(() => const HomeScreen());
  }

  void updateProfile() async {
    UserModel? user = Constant.user?.copyWith(
      firstName: firstName.text,
      lastName: lastName.text,
    );
    if (profileRef != null) {
      LoadingHelper.showLoading();
      final imgUrl = await FirestoreStorage.uploadStoreImg(profileRef!.path);
      LoadingHelper.hideLoading();
      user = user?.copyWith(imgUrl: imgUrl);
    }
    Constant.user = user!;
    final isSuccess = await FirestoreService.updateProfile(user);
    if (!isSuccess) return;
    final controller = Get.put(UserController());
    controller.updateUserState(user);
    Get.off(() => const HomeScreen());
  }
}
