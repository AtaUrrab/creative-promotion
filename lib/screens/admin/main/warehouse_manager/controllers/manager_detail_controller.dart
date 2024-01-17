import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../models/supply_stock_model.dart';
import '../../../../../models/user_model.dart';
import '../views/supply_data.dart';

class ManagerDetailController extends GetxController {
  DateTime? firstDate;
  DateTime? secondDate;
  String? firstDateText;
  String? secondDateText;
  bool isFirstSelect = false;
  bool isSecondSelect = false;
  UserModel? managerModel;
  List<SupplyModel> supplyDetailsList = [];
  List<SupplyModel> selectedSupplyList = [];
  bool isFetchedData = false;

  @override
  onInit() {
    super.onInit();
    managerModel = Get.arguments["managerModel"];
    awaitMethod();
  }

  awaitMethod() async {
    await firebaseFetchMethod();
  }

  //Get Store Data from Firebase
  firebaseFetchMethod() async {
    final db = await FirebaseFirestore.instance
        .collection(Collection.supply.name)
        .where("createdBy", isEqualTo: managerModel!.uid)
        .orderBy("createdAt")
        .get();

    supplyDetailsList =
        db.docs.map((doc) => SupplyModel.fromMap(doc.data())).toList();
  }

  //Date Picker function
  datePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    update();
    if (date == null) return;
    return date;
  }

  // Select First date
  firstDateMethod(BuildContext context) async {
    firstDate = await datePicker(context);
    if (firstDate == null) return;
    firstDateText =
        DateFormat("dd-MM-yyyy").format(firstDate ?? DateTime.now());
    isFirstSelect = true;
    update();
  }

  // Select Second date
  secondDateMethod(BuildContext context) async {
    secondDate = await datePicker(context);
    if (secondDate == null) return;
    secondDateText =
        DateFormat("dd-MM-yyyy").format(secondDate ?? DateTime.now());
    isSecondSelect = true;
    update();
  }

  //On Search Click Function
  onSearchFunction() async {
    selectedSupplyList.clear();
    isFetchedData = false;
    update();
    Get.to(() => const SupplyData());
    selectedSupplyList = supplyDetailsList.where((store) {
      return store.createdAt.toDate().isAfter(firstDate!) &&
              store.createdAt.toDate().isBefore(secondDate!) ||
          store.createdAt.toDate().isAtSameMomentAs(firstDate!) ||
          store.createdAt.toDate().isAtSameMomentAs(secondDate!);
    }).toList();
    await Future.delayed(const Duration(seconds: 1));
    isFetchedData = true;
    update();
  }
}
