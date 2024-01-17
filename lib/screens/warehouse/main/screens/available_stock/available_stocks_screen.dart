import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/references.dart';
import '../../../../../core/constant/constant.dart';
import '../../../../../core/constant/enums.dart';
import '../../../../../models/stocks_model.dart';

class AvailableStockScreen extends StatelessWidget {
  const AvailableStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text(
              "Available Stock",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection(Collection.stocks.name)
                  .where("createdBy", isEqualTo: Constant.user!.uid)
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.size == 0) {
                  return const Center(
                    child: Text(
                      "No Stocks Available!",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  );
                }
                final List<StockModel> stocksNewModel = snapshot.data!.docs
                    .map((doc) => StockModel.fromMap(doc.data()))
                    .toList();
                return SingleChildScrollView(
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
                        rows: stocksNewModel.map((stock) {
                          DateTime formatedDate =
                              DateTime.fromMillisecondsSinceEpoch(
                                  stock.createdAt!.seconds * 1000);
                          return DataRow(
                            cells: [
                              DataCell(Text(stock.catagory ?? "")),
                              DataCell(Align(
                                alignment: Alignment.center,
                                child: Text(DateFormat("dd/MM/yyyy - h:m a")
                                    .format(formatedDate)),
                              )),
                              DataCell(Align(
                                alignment: Alignment.center,
                                child: Text("${stock.quantity}"),
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
