import 'dart:io';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../core/utils/loading_helper.dart';
import '../../../../../models/stocks_model.dart';
import '../screens/admin_warehouse_stock_2.dart';

class AdminWarehouseStockController extends GetxController {
  String uid = '';
  String catagoryID = "";
  String typeID = "";

  void onTap(String value) {
    uid = value;
    update();
    Get.to(() => const AdminWarehouseStockScreen2());
  }

  void weeklyDownloadData(List<StockModel> data) async {
    final excel = Excel.createExcel();
    final sheet1 = excel['Sheet1'];
    LoadingHelper.showLoading();
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "Date";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "Category";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "Quantity";

    for (int row = 0; row < data.length; row++) {
      DateTime formatedDate = DateTime.fromMillisecondsSinceEpoch(
          data[row].createdAt!.seconds * 1000);
      sheet1
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
          .value = DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
      sheet1
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
          .value = data[row].catagory;
      sheet1
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
          .value = data[row].quantity;
    }
    //**********************************
    final fileBytes = excel.save();
    final directory = await getApplicationDocumentsDirectory();
    LoadingHelper.hideLoading();
    final path =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.xlsx';
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    OpenFile.open(path);
    //**********************************
  }
}
