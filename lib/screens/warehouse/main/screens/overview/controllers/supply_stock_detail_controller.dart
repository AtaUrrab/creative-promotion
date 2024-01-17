import 'dart:io';

import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/utils/loading_helper.dart';
import '../../../../../../models/supply_stock_model.dart';

class SupplyStockDetailController extends GetxController {
  void dailyDownloadData(SupplyModel data) async {
    final excel = Excel.createExcel();
    final sheet1 = excel['Sheet1'];

    LoadingHelper.showLoading();
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        "Date";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
        "Warehouse Name";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
        "Agent Name";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
        "Email Address";
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
        'Full Synthethic  - OW-20';
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
        'Full Synthethic  - 5W-20';
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
        'Full Synthethic  - 5W-30';
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
        'High Mileage  - OW-20';
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
        'High Mileage  - OW-20';
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
        'High Mileage  - OW-20';
    sheet1
        .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0))
        .value = 'Advance  - OW-20';
    sheet1
        .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0))
        .value = 'Advance  - OW-20';
    sheet1
        .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0))
        .value = 'Advance  - OW-20';

    DateTime formatedDate =
        DateTime.fromMillisecondsSinceEpoch(data.date.seconds * 1000);
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
        DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value =
        data.warehouseName;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value =
        data.agentName;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 1)).value =
        data.emailAddress;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 1)).value =
        data.fullySyntyheticOW20;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 1)).value =
        data.fullySyntyhetic5W20;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 1)).value =
        data.fullySyntyhetic5W30;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 1)).value =
        data.highMileageOW20;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 1)).value =
        data.highMileage5W20;
    sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 1)).value =
        data.highMileage5W30;
    sheet1
        .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 1))
        .value = data.advanceOW20;
    sheet1
        .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 1))
        .value = data.advance5W20;
    sheet1
        .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 1))
        .value = data.advance5W30;
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
