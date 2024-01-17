import 'package:creativepromotion/models/stocks_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/warehouse_stock_2.dart';

class WarehouseStockController extends GetxController {
  String uid = '';
  StockModel stocksNewModel = StockModel();
  TextEditingController quantity = TextEditingController();

  void onTap(String value) {
    uid = value;
    update();
    Get.to(() => const WarehouseStockScreen2());
  }
}
