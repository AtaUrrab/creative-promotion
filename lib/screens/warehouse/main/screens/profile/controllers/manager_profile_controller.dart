import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/controllers/user_controller.dart';
import '../../../../../../core/helpers/helper_class.dart';
import '../../../../../../core/services/firebase/database/firestore_storage.dart';
import '../../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../../core/utils/loading_helper.dart';
import '../../../../../../core/widgets/native_action_sheet.dart';
import '../../../../../../models/user_model.dart';
import '../../main_screen.dart';

class ManagerProfileController extends GetxController {
  File? profileIMG;
  String warehouseIMG = "";
  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController(text: Constant.user!.firstName);
  final lastName = TextEditingController(text: Constant.user!.lastName);
  final email = TextEditingController(text: Constant.user!.email);
  final phone = TextEditingController(text: Constant.user!.phone);
  final warehouseName =
      TextEditingController(text: Constant.user!.manager!.name);
  final warehouseNo =
      TextEditingController(text: Constant.user!.manager!.number);
  final warehouseAddress =
      TextEditingController(text: Constant.user!.manager!.address);
  final warehouseSize =
      TextEditingController(text: Constant.user!.manager!.size.toString());
  final warehouseState =
      TextEditingController(text: Constant.user!.manager!.state);
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
  profileImage(BuildContext context) async {
    await showAdaptiveActionSheet(
      context: context,
      title: const Text('Profile photo'),
      androidBorderRadius: 30,
      actions: [
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: () async {
              profileIMG = await _pickImage(ImageSource.gallery);
              Get.back();
            }),
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: () async {
              profileIMG = await _pickImage(ImageSource.camera);
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

  void profileUpdate() async {
    if (!formKey.currentState!.validate()) return;
    if (profileIMG != null) {
      try {
        WarehouseDetails warehouseDetails = WarehouseDetails(
            name: warehouseName.text,
            address: warehouseAddress.text,
            number: warehouseNo.text,
            size: int.parse(warehouseSize.text),
            state: warehouseState.text,
            storeImgUrl: warehouseIMG);
        UserModel? user = Constant.user?.copyWith(manager: warehouseDetails);
        if (profileIMG != null) {
          LoadingHelper.showLoading();
          final imgUrl =
              await FirestoreStorage.uploadStoreImg(profileIMG!.path);
          LoadingHelper.hideLoading();
          Constant.user = user!;
          user = user.copyWith(imgUrl: imgUrl);
        }
        final isSuccess = await FirestoreService.updateProfile(user!);
        if (!isSuccess) return;
        final userController = Get.put(UserController());
        userController.updateUserState(user);
        Get.off(() => const MainScreen());
      } catch (e) {
        Get.snackbar("Update Error", e.toString());
      }
    }
    if (warehouseIMG.isNotEmpty) {
      return;
    }
  }
}
