import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/utils/functions.dart';
import 'package:creativepromotion/models/store_notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/utils/loading_helper.dart';
import '../../../../models/store_list_model.dart';

class TodoTaskController extends GetxController {
  StoreListModel storesListModel = StoreListModel();
  DateTime assignDate = DateTime.now();
  DateTime dueDate = DateTime.now();
  bool isClickedCross = false;
  int? storeIndex;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  bool isFetched = false;
  TextEditingController resonText = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    awaitMethod();
  }

  awaitMethod() async {
    await firebaseGetMethod();
  }

  // Get Store Model Form Firebase
  firebaseGetMethod() async {
    final db = await firebase
        .collection("allStoresList")
        .where("docId", isEqualTo: Constant.user?.uid)
        .get();
    storesListModel = StoreListModel.fromMap(db.docs.first.data());

    update();
    assignDate = DateTime.fromMillisecondsSinceEpoch(
        storesListModel.assigningDate!.seconds * 1000);
    dueDate = DateTime.fromMillisecondsSinceEpoch(
        storesListModel.endDate!.seconds * 1000);
    isFetched = true;
    update();
  }

  // Check Click Function
  onClickedCheckMethod(int index) async {
    isClickedCross = false;
    storeIndex = index;
    update();
    final result = await alertDialogMethod();
    if (result == OkCancelResult.ok) {
      await storeNotification(index);
    }
  }

  //Cross Click Function
  onClickedCrossMethod(index) async {
    isClickedCross = !isClickedCross;
    storeIndex = index;
    update();
  }

  // on save button clicked
  onSaveButton(int index) async {
    if (!formKey.currentState!.validate()) return;
    storeNotification(index);
  }

  // Adaptive Dialog Method
  Future<dynamic> alertDialogMethod() {
    return showOkCancelAlertDialog(
      context: Get.context!,
      title: "Delete a store.",
      message: "Do you visit this store?",
      okLabel: "YES",
      cancelLabel: "NO",
    );
  }

  //
  // Delete Store from the Firebase & Store Notification Section
  storeNotification(int index) async {
    LoadingHelper.showLoading();
    try {
      StoreNotificationModel storeNotificationModel = StoreNotificationModel();
      storeNotificationModel.agentID = Constant.user?.uid;
      storeNotificationModel.agentName =
          "${Constant.user?.firstName} ${Constant.user?.lastName}";
      storeNotificationModel.createdAt = Timestamp.now();
      storeNotificationModel.notificationId = getRandomString(25);
      if (isClickedCross == true) {
        storeNotificationModel.isDecline = true;
      } else {
        storeNotificationModel.isDecline = false;
      }

      storeNotificationModel.notificationView = false;
      storeNotificationModel.storeName = storesListModel.storesList![index];
      storeNotificationModel.declineReason = resonText.text.trim();

      await firebase
          .collection("storeNotification")
          .doc(storeNotificationModel.notificationId)
          .set(storeNotificationModel.toMap())
          .then((value) async {
        update();
        resonText.clear();
        storesListModel.storesList!.remove(storesListModel.storesList![index]);
        await firebase
            .collection("allStoresList")
            .doc(storesListModel.docId)
            .set(storesListModel.toMap());
        update();
        isClickedCross = false;
        LoadingHelper.hideLoading();
      });
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

// // showing data from excel file at flutter app
//   void showingExcelData() async {
//     final url = Uri.parse('${storesListModel.storesList}');
//     final response = await get(url);
//     if (response.statusCode == 200) {
//       final List<int> bytes = response.bodyBytes;
//       final excel = Excel.decodeBytes(bytes);
//       for (var table in excel.tables.keys) {
//         var sheet = excel.tables[table]!;
//         for (int row = 0; row < sheet.maxRows; row++) {
//           sheet.row(row).forEach((cell) {
//             var val = cell?.value;
//             storeNamesList.add("$val");
//           });
//         }
//       }
//       update();
//     } else {
//       Get.snackbar("Error", "Failed to fetch Excel file");
//     }
//     update();
//   }
}
