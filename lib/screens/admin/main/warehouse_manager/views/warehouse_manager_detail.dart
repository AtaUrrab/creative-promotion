import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/others.dart';
import '../../../../../core/widgets/textfield.dart';
import '../controllers/manager_detail_controller.dart';
import '../controllers/warehouse_manager_controller.dart';

class WarehouseManagerDetail extends StatelessWidget {
  const WarehouseManagerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManagerDetailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Manager Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<ManagerDetailController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleImage(
                        heading:
                            "${controller.managerModel?.firstName} ${controller.managerModel?.lastName}",
                        imageUrl: controller.managerModel?.imgUrl,
                        size: 100,
                        fontSize: 26,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${controller.managerModel?.firstName} ${controller.managerModel?.lastName}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${controller.managerModel?.email}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Name: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${controller.managerModel?.firstName} ${controller.managerModel?.lastName}",
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(children: [
                                  const TextSpan(
                                    text: "Email: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.managerModel?.email,
                                  )
                                ]),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Phone: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text: controller.managerModel?.phone)
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Warehouse Name: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text: controller
                                            .managerModel?.manager!.name)
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Warehouse Address: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text: controller
                                            .managerModel?.manager!.number)
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Warehouse State: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text: controller
                                            .managerModel?.manager!.state)
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Warehouse Size: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text:
                                            "${controller.managerModel?.manager!.size} sq ft")
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Dates:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller:
                        TextEditingController(text: controller.firstDateText),
                    onTap: () => controller.firstDateMethod(context),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "To",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller:
                        TextEditingController(text: controller.secondDateText),
                    onTap: () => controller.secondDateMethod(context),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      title: "Search ",
                      onTap:
                          controller.isFirstSelect && controller.isSecondSelect
                              ? () {
                                  controller.onSearchFunction();
                                }
                              : null,
                    ),
                  ),
                  const SizedBox(height: 30),

                  const SizedBox(height: 10),
                  // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection(Collection.supply.name)
                  //         .where("createdBy",
                  //             isEqualTo: controller.managerModel?.uid)
                  //         .orderBy("createdAt")
                  //         .snapshots(),
                  //     builder: (context, snapshot) {
                  //       if (!snapshot.hasData || snapshot.data!.size == 0) {
                  //         return const Card(
                  //           child: Padding(
                  //             padding: EdgeInsets.symmetric(vertical: 15.0),
                  //             child: Center(
                  //               child: Text(
                  //                 "No Data Available!",
                  //                 style: TextStyle(
                  //                     fontSize: 18.0, fontWeight: FontWeight.bold),
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //       final List<SupplyModel> supplyDetails = snapshot.data!.docs
                  //           .map((doc) => SupplyModel.fromMap(doc.data()))
                  //           .toList();
                  //       List<SupplyModel> currentWeek = [];
                  //       List<List<SupplyModel>> weeklyData = [];
                  //       for (int i = 0; i < supplyDetails.length; i++) {
                  //         SupplyModel currentDate = supplyDetails[i];
                  //         if (currentWeek.isEmpty ||
                  //             currentDate.createdAt
                  //                     .toDate()
                  //                     .difference(
                  //                         currentWeek.first.createdAt.toDate())
                  //                     .inDays <=
                  //                 6) {
                  //           currentWeek.add(currentDate);
                  //         } else {
                  //           weeklyData.add(List.from(currentWeek));
                  //           currentWeek.clear();
                  //           currentWeek.add(currentDate);
                  //         }
                  //       }
                  //       weeklyData.add(currentWeek);

                  //       return Column(
                  //         children: [
                  //           Row(
                  //             children: [
                  //               const Text(
                  //                 "Weekly Reports",
                  //                 style: TextStyle(
                  //                     fontSize: 18, fontWeight: FontWeight.bold),
                  //                 textAlign: TextAlign.left,
                  //               ),
                  //               const Spacer(),
                  //               IconButton(
                  //                 onPressed: () =>
                  //                     _allWeeksDownloadData(weeklyData),
                  //                 icon: const Icon(Icons.download),
                  //               )
                  //             ],
                  //           ),
                  //           Card(
                  //             child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 itemCount: weeklyData.length,
                  //                 itemBuilder: (context, index) {
                  //                   return ExpansionTile(
                  //                     title: Text('Week ${index + 1}'),
                  //                     controlAffinity:
                  //                         ListTileControlAffinity.leading,
                  //                     trailing: IconButton(
                  //                       icon: const Icon(Icons.download),
                  //                       onPressed: () =>
                  //                           _weeklyDownloadData(weeklyData[index]),
                  //                     ),
                  //                     children: <Widget>[
                  //                       ListView.builder(
                  //                         itemCount: weeklyData[index].length,
                  //                         physics:
                  //                             const NeverScrollableScrollPhysics(),
                  //                         shrinkWrap: true,
                  //                         itemBuilder: (context, i) {
                  //                           final data = weeklyData[index][i];
                  //                           return ListTile(
                  //                             title: Text(data.agentName),
                  //                             subtitle: Row(
                  //                               children: [
                  //                                 Text(data.emailAddress),
                  //                                 const SizedBox(width: 30),
                  //                                 Text(DateFormat("dd-MM-yy")
                  //                                     .format(
                  //                                         data.createdAt.toDate())),
                  //                               ],
                  //                             ),
                  //                             trailing: InkWell(
                  //                               onTap: () {
                  //                                 _dailyDownloadData(data);
                  //                               },
                  //                               child: const Padding(
                  //                                 padding: EdgeInsets.all(8.0),
                  //                                 child: Icon(Icons.download,
                  //                                     color: Colors.blue),
                  //                               ),
                  //                             ),
                  //                             onTap: () {
                  //                               Get.to(() => SupplyDetailScreen(
                  //                                   data: weeklyData[index][i]));
                  //                             },
                  //                           );
                  //                         },
                  //                       )
                  //                     ],
                  //                   );
                  //                 }),
                  //           ),
                  //         ],
                  //       );
                  //     }),
                  // const SizedBox(height: 10),
                  const Text(
                    "Actions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MaterialButton(
                              onPressed: () =>
                                  controller.managerModel?.status !=
                                          UserStatus.decline.name
                                      ? _restrictAgent(context,
                                          controller.managerModel?.uid ?? "")
                                      : _unRestrictAgent(context,
                                          controller.managerModel?.uid ?? ""),
                              color: controller.managerModel?.status !=
                                      UserStatus.decline.name
                                  ? Colors.red
                                  : Colors.green,
                              child: Text(
                                  controller.managerModel?.status !=
                                          UserStatus.decline.name
                                      ? "Restricted user"
                                      : "Unrestricted user",
                                  style: const TextStyle(color: Colors.white)),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _restrictAgent(BuildContext context, String uid) {
    final controller = Get.put(WarehouseManagerController());
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Restricted agent'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Do you really want to restrict this agent?'),
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
                    'Restrict',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    controller.restrictAgent(uid);
                  },
                ),
              ]);
        });
  }

  _unRestrictAgent(BuildContext context, String uid) {
    final controller = Get.put(WarehouseManagerController());
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Unrestricted agent'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to unrestrict this agent?'),
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
                    'Unrestricted',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    controller.unRestrictAgent(uid);
                  },
                ),
              ]);
        });
  }
}

// void _allWeeksDownloadData(List<List<SupplyModel>> allDataLists) {
//   List<SupplyModel> finalDataList = [];
//   for (var oneWeek in allDataLists) {
//     finalDataList.addAll(oneWeek);
//   }
//   _weeklyDownloadData(finalDataList);
// }

// void _weeklyDownloadData(List<SupplyModel> data) async {
//   final excel = Excel.createExcel();
//   final sheet1 = excel['Sheet1'];

//   LoadingHelper.showLoading();
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
//       "Date";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
//       "Warehouse Name";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
//       "Agent Name";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
//       "Email Address";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
//       'Full Synthethic  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
//       'Full Synthethic  - 5W-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
//       'Full Synthethic  - 5W-30';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
//       'High Mileage - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
//       'High Mileage - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
//       'High Mileage - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0)).value =
//       'Advance  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0)).value =
//       'Advance  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0)).value =
//       'Advance  - OW-20';

//   for (int row = 0; row < data.length; row++) {
//     DateTime formatedDate =
//         DateTime.fromMillisecondsSinceEpoch(data[row].date.seconds * 1000);
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
//         .value = DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
//         .value = data[row].warehouseName;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
//         .value = data[row].agentName;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
//         .value = data[row].emailAddress;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
//         .value = data[row].fullySyntyheticOW20;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
//         .value = data[row].fullySyntyhetic5W20;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
//         .value = data[row].fullySyntyhetic5W30;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1))
//         .value = data[row].highMileageOW20;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1))
//         .value = data[row].highMileage5W20;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row + 1))
//         .value = data[row].highMileage5W30;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row + 1))
//         .value = data[row].advanceOW20;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: row + 1))
//         .value = data[row].advance5W20;
//     sheet1
//         .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: row + 1))
//         .value = data[row].advance5W30;
//   }
//   //**********************************
//   final fileBytes = excel.save();
//   final directory = await getApplicationDocumentsDirectory();
//   LoadingHelper.hideLoading();
//   final path =
//       '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.xlsx';
//   File(path)
//     ..createSync(recursive: true)
//     ..writeAsBytesSync(fileBytes!);
//   OpenFile.open(path);
//   //**********************************
// }

// void _dailyDownloadData(SupplyModel data) async {
//   final excel = Excel.createExcel();
//   final sheet1 = excel['Sheet1'];

//   LoadingHelper.showLoading();
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
//       "Date";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value =
//       "Warehouse Name";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value =
//       "Agent Name";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value =
//       "Email Address";
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value =
//       'Full Synthethic  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value =
//       'Full Synthethic  - 5W-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0)).value =
//       'Full Synthethic  - 5W-30';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0)).value =
//       'High Mileage  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0)).value =
//       'High Mileage  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0)).value =
//       'High Mileage  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0)).value =
//       'Advance  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0)).value =
//       'Advance  - OW-20';
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0)).value =
//       'Advance  - OW-20';

//   DateTime formatedDate =
//       DateTime.fromMillisecondsSinceEpoch(data.date.seconds * 1000);
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
//       DateFormat("dd/MM/yyyy - h:m a").format(formatedDate);
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 1)).value =
//       data.warehouseName;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 1)).value =
//       data.agentName;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 1)).value =
//       data.emailAddress;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 1)).value =
//       data.fullySyntyheticOW20;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 1)).value =
//       data.fullySyntyhetic5W20;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 1)).value =
//       data.fullySyntyhetic5W30;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 1)).value =
//       data.highMileageOW20;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 1)).value =
//       data.highMileage5W20;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 1)).value =
//       data.highMileage5W30;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 1)).value =
//       data.advanceOW20;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 1)).value =
//       data.advance5W20;
//   sheet1.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 1)).value =
//       data.advance5W30;
//   //**********************************
//   final fileBytes = excel.save();
//   final directory = await getApplicationDocumentsDirectory();
//   LoadingHelper.hideLoading();
//   final path =
//       '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.xlsx';
//   File(path)
//     ..createSync(recursive: true)
//     ..writeAsBytesSync(fileBytes!);
//   OpenFile.open(path);
//   //**********************************
// }
