import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/constant.dart';
import 'package:creativepromotion/screens/agent/main/add_store/views/add_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/controllers/user_controller.dart';
import '../../../../core/services/firebase/database/firestore_storage.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../../../../core/utils/loading_helper.dart';
import '../../../../core/widgets/native_action_sheet.dart';
import '../../../../models/user_model.dart';
import '../add_store/controllers/add_controller.dart';

class ProfileController extends GetxController {
  final UserModel? _user;
  ProfileController({required UserModel user}) : _user = user;
  File? profileRef;
  final ImagePicker _imagePicker = ImagePicker();
  final phone = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final area = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    if (_user != null) {
      firstName.text = _user!.firstName;
      lastName.text = _user!.lastName;
      phone.text = _user!.phone;
      area.text = _user!.area;
    }
  }

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
  changeImage(BuildContext context) async {
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
      return;
    }
    LoadingHelper.showLoading();
    await FirebaseStorage.instance.refFromURL(Constant.user!.imgUrl).delete();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(Constant.user!.uid)
        .update(
      {"imgUrl": null},
    );
    UserModel? user = Constant.user?.copyWith(imgUrl: null);
    Constant.user = user;
    update();
    final controller = Get.put(UserController());
    controller.updateUserState(user!);
    final addController = Get.put(AddController());
    addController.update();
    LoadingHelper.hideLoading();
    Get.off(() => const AddScreen());
  }

//*********************** User Details Update Method */
  Future<void> submit() async {
    try {
      UserModel? user = Constant.user?.copyWith(
        firstName: Constant.user!.firstName,
        lastName: Constant.user!.lastName,
        area: area.text,
        phone: phone.text,
        snnNo: null,
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
      final userController = Get.put(UserController());
      userController.updateUserState(user);
      Get.off(() => const AddScreen());
    } catch (e) {
      log(e.toString());
    }
  }
}
