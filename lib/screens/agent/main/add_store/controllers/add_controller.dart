import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/constant/enums.dart';
import '../../../../../core/controllers/user_controller.dart';
import '../../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../../core/services/firebase/database/firestore_storage.dart';
import '../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../core/utils/loading_helper.dart';
import '../../../../../models/store_model.dart';
import '../../../../splash/views/select_user_screen.dart';
import '../views/agreement_screen.dart';
import '../views/oil_image.dart';
import '../views/signature_screen.dart';
import '../views/store_image.dart';
import '../views/thank_you_screen.dart';

class AddController extends GetxController {
  final firstFormKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();
  final categoryFormKey = GlobalKey<FormState>();
  bool isSelectColdVault = false;
  bool isFirstAggrement = false;
  bool isSecondAggrement = false;
  final storeName = TextEditingController();
  final storePhone = TextEditingController();
  final storeEmail = TextEditingController();
  final storeAddress = TextEditingController();
  final title = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final additionalInfo = TextEditingController();
  String frontStoreImage = "";
  String frontDoorImage = "";
  String beforeOilImage = "";
  String afterOilImage = "";
  String coldVault = "";
  String signature = "";
  String designation = "Owner";
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? userListener;
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  List<String> categoryList = <String>[
    'Full Synthethic - OW-20',
    'Full Synthethic - 5W-20',
    'Full Synthethic - 5W-30',
    'High Mileag - OW-20',
    'High Mileag - 5W-20',
    'High Mileag - 5W-30',
    'Advanc - OW-20',
    'Advanc - 5W-20',
    'Advanc - 5W-30',
  ];
  final fullySyntyheticOW20 = TextEditingController();
  final fullySyntyhetic5W20 = TextEditingController();
  final fullySyntyhetic5W30 = TextEditingController();
  final highMileageOW20 = TextEditingController();
  final highMileage5W20 = TextEditingController();
  final highMileage5W30 = TextEditingController();
  final advanceOW20 = TextEditingController();
  final advance5W20 = TextEditingController();
  final advance5W30 = TextEditingController();
  bool isSyncthethicSelectedOW20 = false;
  bool isSyncthethicSelected5W20 = false;
  bool isSyncthethicSelected5W30 = false;
  bool isMileageSelectedOW20 = false;
  bool isMileageSelected5W20 = false;
  bool isMileageSelected5W30 = false;
  bool isAdvanceSelectedOW20 = false;
  bool isAdvanceSelected5W20 = false;
  bool isAdvanceSelected5W30 = false;
  FocusNode fieldFullySyntyheticOW20 = FocusNode();
  FocusNode fieldFullySyntyhetic5W20 = FocusNode();
  FocusNode fieldFullySyntyhetic5W30 = FocusNode();
  FocusNode fieldHighMileageOW20 = FocusNode();
  FocusNode fieldHighMileage5W20 = FocusNode();
  FocusNode fieldHighMileage5W30 = FocusNode();
  FocusNode fieldAdvanceOW20 = FocusNode();
  FocusNode fieldAdvance5W20 = FocusNode();
  FocusNode fieldAdvance5W30 = FocusNode();

  @override
  void onInit() {
    _listenUserStatus();
    super.onInit();
  }

  void add() {
    if (!firstFormKey.currentState!.validate()) return;
    if (designation.isEmpty) {
      Get.snackbar("Message", "please select your designation");
      return;
    }
    Get.to(() => const AgreementScreen());
  }

  void gotoOilScreen() {
    if (!secondFormKey.currentState!.validate()) return;
    if (!isFirstAggrement || !isSecondAggrement) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar("Message", "Please accept the aggrements first");
      return;
    }
    Get.to(() => const OilImageScreen());
  }

  void gotoStoreImageScreen() {
    if (beforeOilImage.isEmpty || afterOilImage.isEmpty) {
      Get.snackbar("Message", "Please attach images below");
      return;
    }
    Get.to(() => const StoreImageScreen());
  }

  void gotoSignatureScreen() {
    if (frontStoreImage.isEmpty || frontDoorImage.isEmpty) {
      Get.snackbar("Message", "Please attach images below");
      return;
    }
    Get.to(() => const SignatureScreen());
  }

  void gotoThankYouScreen() {
    if (isSelectColdVault && coldVault.isEmpty) {
      Get.snackbar("Message", "Please attach images below");
      return;
    }
    if (signature.isEmpty) {
      Get.snackbar("Message", "Please add your signature");
      return;
    }
    if (!categoryFormKey.currentState!.validate()) {
      return;
    }
    LoadingHelper.showLoading();
    assigningStockMethod();

    LoadingHelper.hideLoading();
    Get.offAll(() => const ThankYouScreen());
  }

  assigningStockMethod() async {
    if (fullySyntyheticOW20.text.isEmpty) {
      fullySyntyheticOW20.text = "0";
    }
    if (fullySyntyhetic5W20.text.isEmpty) {
      fullySyntyhetic5W20.text = "0";
    }
    if (fullySyntyhetic5W30.text.isEmpty) {
      fullySyntyhetic5W30.text = "0";
    }
    if (highMileageOW20.text.isEmpty) {
      highMileageOW20.text = "0";
    }
    if (highMileage5W20.text.isEmpty) {
      highMileage5W20.text = "0";
    }
    if (highMileage5W30.text.isEmpty) {
      highMileage5W30.text = "0";
    }
    if (advanceOW20.text.isEmpty) {
      advanceOW20.text = "0";
    }
    if (advance5W20.text.isEmpty) {
      advance5W20.text = "0";
    }
    if (advance5W30.text.isEmpty) {
      advance5W30.text = "0";
    }

    await _uploadData();
  }

  Future _uploadData() async {
    final id = getRandomString(25);
    final images = <ImageModel>[];
    frontStoreImage = await FirestoreStorage.uploadStoreImg(frontStoreImage);
    frontDoorImage = await FirestoreStorage.uploadStoreImg(frontDoorImage);
    beforeOilImage = await FirestoreStorage.uploadStoreImg(beforeOilImage);
    afterOilImage = await FirestoreStorage.uploadStoreImg(afterOilImage);
    signature = await FirestoreStorage.uploadStoreImg(signature);
    if (isSelectColdVault) {
      coldVault = await FirestoreStorage.uploadStoreImg(coldVault);
    }
    images.addAll([
      ImageModel(
        createdAt: Timestamp.now(),
        imageName: "beforeOilImage",
        order: 0,
        type: "png",
        imgUrl: beforeOilImage,
      ),
      ImageModel(
        createdAt: Timestamp.now(),
        imageName: "afterOilImage",
        order: 1,
        type: "png",
        imgUrl: afterOilImage,
      ),
      ImageModel(
        createdAt: Timestamp.now(),
        imageName: "frontStoreImage",
        order: 2,
        type: "png",
        imgUrl: frontStoreImage,
      ),
      ImageModel(
        createdAt: Timestamp.now(),
        imageName: "frontDoorImage",
        order: 3,
        type: "png",
        imgUrl: frontDoorImage,
      ),
      ImageModel(
        createdAt: Timestamp.now(),
        imageName: "coldVault",
        order: 4,
        type: "png",
        imgUrl: coldVault,
      ),
    ]);
    final signatureModel = SignatureModel(
        createdAt: Timestamp.now(),
        imgUrl: signature,
        signatureName: "signature",
        type: "png");
    //**************************** */
    final store = StoreModel(
      images: images,
      id: id,
      addById: Constant.user!.uid,
      designation: Designation(
        designation: designation,
        email: email.text.trim(),
        name: name.text.trim(),
      ),
      signature: signatureModel,
      storeName: storeName.text,
      storeEmail: storeEmail.text,
      storeAddress: storeAddress.text,
      storePhone: storePhone.text,
      createdAt: Timestamp.now(),
      comission: Constant.user!.commision,
      additionalInfo: additionalInfo.text,
      fullySyntyheticOW20: fullySyntyheticOW20.text,
      fullySyntyhetic5W20: fullySyntyhetic5W20.text,
      fullySyntyhetic5W30: fullySyntyhetic5W30.text,
      highMileageOW20: highMileageOW20.text,
      highMileage5W20: highMileage5W20.text,
      highMileage5W30: highMileage5W30.text,
      advanceOW20: advanceOW20.text,
      advance5W20: advance5W20.text,
      advance5W30: advance5W30.text,
    );
    final isSuccess = await FirestoreService.setStoreData(store);
    if (isSuccess) {
      await FirestoreService.incrementComission(
        Constant.user!.commision + Constant.user!.totalCommision,
      );
      Get.put(UserController()).getUserData();
    }
  }

  void delete(BuildContext context, String id) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Delete Store'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to delete the store data?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    FirestoreService.deleteStore(id);
                  },
                ),
              ]);
        });
  }

  void _listenUserStatus() {
    userListener = FirebaseFirestore.instance
        .collection(Collection.users.name)
        .doc(Constant.user!.uid)
        .snapshots()
        .listen((doc) async {
      if (!doc.exists) return;
      if (doc.data()!["status"] != "approved") {
        Constant.user = null;
        await SignOutService().signOut();
        Get.offAll(() => const SelectUserScreen());
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    userListener?.cancel();
    signatureController.dispose();
    fieldFullySyntyheticOW20.dispose();
    fieldFullySyntyhetic5W20.dispose();
    fieldFullySyntyhetic5W30.dispose();
    fieldHighMileageOW20.dispose();
    fieldHighMileage5W20.dispose();
    fieldHighMileage5W30.dispose();
    fieldAdvanceOW20.dispose();
    fieldAdvance5W20.dispose();
    fieldAdvance5W30.dispose();
  }
}
