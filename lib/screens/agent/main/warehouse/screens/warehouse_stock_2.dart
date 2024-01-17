import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/references.dart';
import '../../../../../../core/widgets/cards.dart';
import '../../../../../../models/stocks_model.dart';
import '../controllers/stocks_controller.dart';

class WarehouseStockScreen2 extends StatelessWidget {
  const WarehouseStockScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WarehouseStockController());
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
              "Warehouse Stock",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: Get.height * 0.5,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(Collection.stocks.name)
                    .where("createdBy", isEqualTo: controller.uid)
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
                  final List<StockModel> stocksNewModelList = snapshot
                      .data!.docs
                      .map((doc) => StockModel.fromMap(doc.data()))
                      .toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: stocksNewModelList.length,
                    itemBuilder: (_, i) => GetBuilder<WarehouseStockController>(
                      builder: (_) {
                        final stock = stocksNewModelList[i];
                        return StockCardWidget(
                          isPriceAvail: true,
                          onTap: null,
                          title: stock.catagory ?? "",
                          quantity: "${stock.quantity}",
                          isSelected: false,
                          isDisable: true,
                        );
                      },
                    ),
                    separatorBuilder: (_, i) => const SizedBox(height: 20),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       SizedBox(
      //         width: double.infinity,
      //         child: GetBuilder<WarehouseStockController>(
      //           builder: (controller) {
      //             return AppButton(
      //               onTap: () => controller.getQuantity(),
      //               title: "Continue",
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // void _continue() {
  //   Get.to(() => const WarehouseStockScreen3());
  // }
}
