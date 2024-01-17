import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/constant/enums.dart';
import '../../../../../core/utils/functions.dart';
import '../../../../../core/utils/loading_helper.dart';
import '../../../../../models/stocks_model.dart';

class UpdateStocksController extends GetxController {
  String typeID = "";
  List<String> categoryList = <String>[
    'Select Category',
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
  String selectedMoboOilCategory = "Select Category";
  TextEditingController moboOilQuantity = TextEditingController();
  List<StockModel> stocksModelList = [];
  String categoryDocID = "";
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  StockModel stockModel = StockModel();
  int catQuantity = 0;

  @override
  onInit() {
    super.onInit();
    getStocksData();
  }

  getStocksData() async {
    final db = await FirebaseFirestore.instance
        .collection(Collection.stocks.name)
        .get();
    stocksModelList =
        db.docs.map((doc) => StockModel.fromMap(doc.data())).toList();
    update();
  }

//************************* OnClick Method */
  onClick() async {
    if (selectedMoboOilCategory.isEmpty ||
        selectedMoboOilCategory == "Select Category" ||
        moboOilQuantity.text.isEmpty) {
      Get.snackbar("Alert", "Must Select one category, Type & quantity");
      return;
    }

    LoadingHelper.showLoading();

    if (stocksModelList
        .any((element) => element.catagory == selectedMoboOilCategory)) {
      final result = stocksModelList
          .firstWhere((element) => element.catagory == selectedMoboOilCategory);
      catQuantity = result.quantity! + int.parse(moboOilQuantity.text);
      await setStockModel(result.id);
      await getStocksData();
    } else {
      catQuantity = int.parse(moboOilQuantity.text);
      await setStockModel(getRandomString(25));
      await getStocksData();
    }
  }

  setStockModel(String? docID) async {
    try {
      final stockesModel = StockModel(
        id: docID,
        createdBy: Constant.user!.uid,
        createdAt: Timestamp.now(),
        catagory: selectedMoboOilCategory,
        quantity: catQuantity,
      );
      await firebaseFirestore
          .collection(Collection.stocks.name)
          .doc(stockesModel.id)
          .set(stockesModel.toMap())
          .then((value) => {
                LoadingHelper.hideLoading(),
                moboOilQuantity.clear(),
                selectedMoboOilCategory == "Select Category",
                stockModel = StockModel(),
                update(),
              });
    } catch (e) {
      LoadingHelper.hideLoading();
      return;
    }
  }
}
