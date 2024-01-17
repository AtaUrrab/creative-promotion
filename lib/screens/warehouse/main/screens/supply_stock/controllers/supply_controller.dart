import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/constant.dart';
import 'package:creativepromotion/core/utils/functions.dart';
import 'package:creativepromotion/models/supply_stock_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/constant/enums.dart';
import '../../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../../core/widgets/dialog_box.dart';
import '../../../../../../models/stocks_model.dart';

class SupplyController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final agentName = TextEditingController();
  final emailAddress = TextEditingController();
  DateTime dateTime = DateTime.now();
  List<String> categoryList = <String>[
    'Full Synthethic - OW-20',
    'Full Synthethic - 5W-20',
    'Full Synthethic - 5W-30',
    'High Mileage - OW-20',
    'High Mileage - 5W-20',
    'High Mileage - 5W-30',
    'Advance - OW-20',
    'Advance - 5W-20',
    'Advance - 5W-30',
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
  List<StockModel> stocksModelList = [];
  int fullySyntyheticOW20Quantity = 0;
  int fullySyntyhetic5W20Quantity = 0;
  int fullySyntyhetic5W30Quantity = 0;
  int highMileageOW20Quantity = 0;
  int highMileage5W20Quantity = 0;
  int highMileage5W30Quantity = 0;
  int advanceOW20Quantity = 0;
  int advance5W20Quantity = 0;
  int advance5W30Quantity = 0;

  @override
  onInit() {
    super.onInit();
    getStocksData();
  }

  getValues() async {
    await getStocksData();
  }

  getStocksData() async {
    final db = await FirebaseFirestore.instance
        .collection(Collection.stocks.name)
        .get();
    stocksModelList =
        db.docs.map((doc) => StockModel.fromMap(doc.data())).toList();
    update();
  }

  onSubmit() async {
    if (!formkey.currentState!.validate()) return;

    // subtract quantity from uploaded quantity
    await updateQuantityMethods();

    //upload supply Data
    uploadSupplyData();
  }

  updateQuantityMethods() async {
    await updateFullySyntyheticOW20();
    await updateFullySyntyhetic5W20();
    await updateFullySyntyhetic5W30();
    await updateHighMileageOW20();
    await updateHighMileage5W20();
    await updateHighMileage5W30();
    await updateAdvanceOW20();
    await updateAdvance5W20();
    await updateAdvance5W30();
  }

  updateFullySyntyheticOW20() {
    try {
      final result = stocksModelList.firstWhere(
          (element) => element.catagory == "Full Synthethic - OW-20");
      final value = result.quantity! - int.parse(fullySyntyheticOW20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateFullySyntyhetic5W20() {
    try {
      final result = stocksModelList.firstWhere(
          (element) => element.catagory == "Full Synthethic - 5W-20");
      final value = result.quantity! - int.parse(fullySyntyhetic5W20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateFullySyntyhetic5W30() {
    final result = stocksModelList
        .firstWhere((element) => element.catagory == "Full Synthethic - 5W-30");
    final value = result.quantity! - int.parse(fullySyntyhetic5W30.text);
    updateStockMethod(result.id ?? "", value);
  }

  updateHighMileageOW20() {
    try {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == "High Mileage - OW-20");
      final value = result.quantity! - int.parse(highMileageOW20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateHighMileage5W20() {
    try {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == "High Mileage - 5W-20");
      final value = result.quantity! - int.parse(highMileage5W20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateHighMileage5W30() {
    try {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == "High Mileage - 5W-30");
      final value = result.quantity! - int.parse(fullySyntyheticOW20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateAdvanceOW20() {
    try {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == "Advance - OW-20");
      final value = result.quantity! - int.parse(fullySyntyheticOW20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateAdvance5W20() {
    try {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == "Advance - 5W-20");
      final value = result.quantity! - int.parse(fullySyntyheticOW20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  updateAdvance5W30() {
    try {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == "Advance - 5W-30");
      final value = result.quantity! - int.parse(fullySyntyheticOW20.text);
      updateStockMethod(result.id ?? "", value);
    } catch (e) {
      return;
    }
  }

  void updateStockMethod(String docID, int quantityValue) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.stocks.name)
          .doc(docID)
          .update(
        {
          "quantity": quantityValue,
          "createdAt": Timestamp.now(),
        },
      );
      update();
    } catch (e) {
      return;
    }
  }

  void uploadSupplyData() async {
    final supply = SupplyModel(
      id: getRandomString(25),
      createdAt: Timestamp.now(),
      createdBy: Constant.user!.uid,
      warehouseName: Constant.user!.manager!.name,
      agentName: agentName.text,
      emailAddress: emailAddress.text,
      date: Timestamp.fromDate(dateTime),
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
    await FirestoreService.setSupplyStock(supply).then((value) => {
          AppDialog.showOSDialog(
            context: Get.context!,
            title: "Message",
            isCrossDisabled: true,
            message: "Your data has been submitted, Thank you!",
            firstButtonText: "",
            firstCallBack: () {},
            secondButtonText: "Done",
            secondCallBack: () {
              Get.back();
              Get.back();
            },
          ),
        });
  }

  @override
  void onClose() {
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
