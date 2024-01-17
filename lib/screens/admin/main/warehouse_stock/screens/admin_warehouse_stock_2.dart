import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/references.dart';
import '../../../../../../models/stocks_model.dart';
import '../../../../../core/utils/colors.dart';
import '../controllers/admin_stocks_controller.dart';

class AdminWarehouseStockScreen2 extends StatelessWidget {
  const AdminWarehouseStockScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminWarehouseStockController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.logo,
                  height: 150,
                ),
              ],
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(Collection.stocks.name)
                  .where("createdBy", isEqualTo: controller.uid)
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.size == 0) {
                  return Container(
                    height: Get.height,
                    padding: EdgeInsets.only(top: Get.height * .2),
                    child: const Text(
                      "No Stock Available!",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }
                final List<StockModel> stocksList = snapshot.data!.docs
                    .map((doc) => StockModel.fromMap(doc.data()))
                    .toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            "Available Stock: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () =>
                                controller.weeklyDownloadData(stocksList),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          child: DataTable(
                              horizontalMargin: 8.0,
                              headingTextStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              headingRowColor:
                                  MaterialStateColor.resolveWith((states) {
                                return AppColor.red;
                              }),
                              columns: const [
                                DataColumn(label: Text("Category")),
                                DataColumn(label: Text("Date and Time")),
                                DataColumn(label: Text("No of Pieces")),
                              ],
                              rows: stocksList.map((stock) {
                                DateTime formatedDate =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        stock.createdAt!.seconds * 1000);
                                return DataRow(
                                  cells: [
                                    DataCell(Text(stock.catagory ?? "")),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          DateFormat("dd/MM/yyyy - h:m a")
                                              .format(formatedDate)),
                                    )),
                                    DataCell(Align(
                                      alignment: Alignment.center,
                                      child: Text("${stock.quantity}"),
                                    )),
                                  ],
                                );
                              }).toList()),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
