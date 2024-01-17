import 'package:get/get.dart';

import '../screens/available_stock/available_stocks_screen.dart';
import '../screens/supply_stock/views/supply_stock.dart';
import '../screens/update_stock/update_stocks_screen.dart';

class MainController extends GetxController {
  String selectedStock = "availableStock";
  final List<Stocks> stocks1 = [
    Stocks("Available Stock", "availableStock"),
    Stocks("Supply Stock", "supplyStock"),
    Stocks("Update Stock", "updateStock"),
  ];

  void onTap(String value) {
    selectedStock = value;
    update();
  }

  void continueMethod(String value) async {
    switch (value) {
      case "availableStock":
        Get.to(() => const AvailableStockScreen());
        break;
      case "supplyStock":
        Get.to(() => const SupplyStockScreen());
        break;
      case "updateStock":
        Get.to(() => const UpdateStockScreen());
        break;
    }
  }
}

class Stocks {
  final String name;
  final String value;

  Stocks(this.name, this.value);
}
