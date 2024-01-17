import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/colors.dart';
import '../controller/agent_overview_controller.dart';
import 'store_detail_screen.dart';

class DatesShowScreen extends StatelessWidget {
  const DatesShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentOverviewController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Overview Data",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<AgentOverviewController>(builder: (_) {
        return controller.isFetchedData == false
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.red,
                backgroundColor: Colors.black,
              ))
            : controller.selectedStores.isEmpty
                ? const Center(
                    child: Text(
                      "No Data!",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.selectedStores.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                            title: Text(
                              controller.selectedStores[i].storeName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle:
                                Text(controller.selectedStores[i].storeEmail),
                            onTap: () => {
                                  Get.to(() => StoreDetailScreen(
                                        store: controller.selectedStores[i],
                                      )),
                                }),
                      );
                    },
                  );
      }),
    );
  }
}
