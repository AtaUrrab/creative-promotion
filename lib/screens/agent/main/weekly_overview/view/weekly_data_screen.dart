// import 'dart:io';

// import 'package:creativepromotion/core/utils/loading_helper.dart';
// import 'package:excel/excel.dart' hide Border;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../../../../core/utils/colors.dart';
// import '../../../../../models/store_model.dart';

// class WeeklyDataScreen extends StatelessWidget {
//   final String title;
//   final List<StoreModel> data;
//   WeeklyDataScreen({super.key, required this.data, required this.title});

//   final List<TableRow> headers = [
//     const TableRow(
//       children: [
//         HeadingWidget(title: "Date\n"),
//         HeadingWidget(title: "Name\n"),
//         HeadingWidget(title: "Phone\n"),
//         HeadingWidget(title: "Email\n"),
//         HeadingWidget(title: "Address\n"),
//         HeadingWidget(title: "Full Synthethic - OW-20"),
//         HeadingWidget(title: "Full Synthethic - 5W-20"),
//         HeadingWidget(title: "Full Synthethic - 5W-30"),
//         HeadingWidget(title: "High Mileage - OW-20"),
//         HeadingWidget(title: "High Mileage - 5W-20"),
//         HeadingWidget(title: "High Mileage - 5W-30"),
//         HeadingWidget(title: "Advance - OW-20"),
//         HeadingWidget(title: "Advance - 5W-20\n"),
//         HeadingWidget(title: "Advance - 5W-30\n"),
//       ],
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () => _download(data),
//             icon: const Icon(Icons.download),
//           ),
//         ],
//         backgroundColor: AppColor.red,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               "Overview",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: SizedBox(
//                 width: Get.width * 5,
//                 child: Table(
//                   border: TableBorder.all(),
//                   children: [
//                     ...headers,
//                     ...data.map(
//                       (storeData) {
//                         return TableRow(
//                           children: [
//                             RowWidget(
//                               rowData: DateFormat('d/M/y')
//                                   .format(storeData.createdAt.toDate()),
//                             ),
//                             RowWidget(rowData: storeData.storeName),
//                             RowWidget(rowData: storeData.storePhone),
//                             RowWidget(rowData: storeData.storeEmail),
//                             RowWidget(rowData: storeData.storeAddress),
//                             RowWidget(rowData: storeData.fullySyntyheticOW20),
//                             RowWidget(rowData: storeData.fullySyntyhetic5W20),
//                             RowWidget(rowData: storeData.fullySyntyhetic5W30),
//                             RowWidget(rowData: storeData.highMileageOW20),
//                             RowWidget(rowData: storeData.highMileage5W20),
//                             RowWidget(rowData: storeData.highMileage5W30),
//                             RowWidget(rowData: storeData.advanceOW20),
//                             RowWidget(rowData: storeData.advance5W20),
//                             RowWidget(rowData: storeData.advance5W30),
//                           ],
//                         );
//                       },
//                     ).toList(),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _download(List<StoreModel> data) async {
//     final excel = Excel.createExcel();
//     final sheet1 = excel['Sheet1'];
//     LoadingHelper.showLoading();
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
//         "Date";
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
//         "Store Name";
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
//         "Store Phone";
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
//         "Store Email";
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
//         "Store Address";
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
//         'Full Synthethic  - OW-20';
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
//         'Full Synthethic  - 5W-20';
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
//         'Full Synthethic  - 5W-30';
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
//         'High Mileage  - OW-20';
//     sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
//         'High Mileage  - OW-20';
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0))
//         .value = 'High Mileage  - OW-20';
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0))
//         .value = 'Advance  - OW-20';
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0))
//         .value = 'Advance  - OW-20';
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 0))
//         .value = 'Advance  - OW-20';
//     for (int row = 0; row < data.length; row++) {
//       DateTime formatedDate = DateTime.fromMillisecondsSinceEpoch(
//           data[row].createdAt.seconds * 1000);
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
//           .value = DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
//           .value = data[row].storeName;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
//           .value = data[row].storePhone;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
//           .value = data[row].storeEmail;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
//           .value = data[row].storeAddress;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
//           .value = data[row].fullySyntyheticOW20;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
//           .value = data[row].fullySyntyhetic5W20;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1))
//           .value = data[row].fullySyntyhetic5W30;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1))
//           .value = data[row].highMileageOW20;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row + 1))
//           .value = data[row].highMileage5W20;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row + 1))
//           .value = data[row].highMileage5W30;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: row + 1))
//           .value = data[row].advanceOW20;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: row + 1))
//           .value = data[row].advance5W20;
//       sheet1
//           .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: row + 1))
//           .value = data[row].advance5W30;
//     }
//     //**********************************
//     final fileBytes = excel.save();
//     final directory = await getApplicationDocumentsDirectory();
//     LoadingHelper.hideLoading();
//     final path =
//         '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.xlsx';
//     File(path)
//       ..createSync(recursive: true)
//       ..writeAsBytesSync(fileBytes!);
//     OpenFile.open(path);
//     //**********************************
//   }
// }

// class RowWidget extends StatelessWidget {
//   const RowWidget({
//     super.key,
//     required this.rowData,
//   });

//   final String rowData;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           rowData,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ),
//     );
//   }
// }

// class BodyWidget extends StatelessWidget {
//   final String title;
//   const BodyWidget({
//     super.key,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: Colors.black,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }

// class HeadingWidget extends StatelessWidget {
//   final String title;
//   const HeadingWidget({
//     super.key,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColor.red,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
