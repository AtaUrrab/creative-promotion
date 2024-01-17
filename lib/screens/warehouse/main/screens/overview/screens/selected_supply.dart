import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/colors.dart';
import '../controllers/warehouse_overview_controller.dart';
import 'supply_stock_detail.dart';

class SelectedSupplyScreen extends StatelessWidget {
  const SelectedSupplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WarehouseOverviewController());
    // log("${controller.}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Overview Data",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<WarehouseOverviewController>(builder: (_) {
        return controller.isFetchedData == false
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.red,
                backgroundColor: Colors.black,
              ))
            : controller.selectedSupplyList.isEmpty
                ? const Center(
                    child: Text(
                      "No Data!",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.selectedSupplyList.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                            title: Text(
                              controller.selectedSupplyList[i].agentName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  controller.selectedSupplyList[i].emailAddress,
                                  overflow: TextOverflow.visible,
                                )),
                                Text(
                                  DateFormat("dd-MM-yyyy").format(controller
                                      .selectedSupplyList[i].createdAt
                                      .toDate()),
                                ),
                              ],
                            ),
                            onTap: () => {
                                  Get.to(() => SupplyDetailScreen(
                                        data: controller.selectedSupplyList[i],
                                      )),
                                }),
                      );
                    },
                  );
      }),
    );
  }
}
