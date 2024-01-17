import 'package:creativepromotion/screens/warehouse/main/screens/overview/controllers/supply_stock_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/supply_stock_model.dart';

class SupplyDetailScreen extends StatelessWidget {
  final SupplyModel data;
  const SupplyDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplyStockDetailController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            data.agentName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        "Supply Stock Detail",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => controller.dailyDownloadData(data),
                        icon: const Icon(Icons.download),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Warehouse Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.warehouseName),
                  const SizedBox(height: 15),
                  const Text(
                    "Agent Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.agentName),
                  const SizedBox(height: 15),
                  const Text(
                    "Email Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.emailAddress),
                  const SizedBox(height: 15),
                  const Text(
                    "Full Synthetic - OW-20",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.fullySyntyheticOW20),
                  const SizedBox(height: 15),
                  const Text(
                    'Full Synthethic  - 5W-20',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.fullySyntyhetic5W20),
                  const SizedBox(height: 15),
                  const Text(
                    'Full Synthethic  - 5W-30',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.fullySyntyhetic5W30),
                  const SizedBox(height: 15),
                  const Text(
                    'High Mileage - OW-20',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.highMileageOW20),
                  const SizedBox(height: 15),
                  const Text(
                    'High Mileage - 5W-20',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.highMileage5W20),
                  const SizedBox(height: 15),
                  const Text(
                    'High Mileage - 5W-30',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.highMileage5W30),
                  const SizedBox(height: 15),
                  const Text(
                    'Advance  - OW-20',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.advanceOW20),
                  const SizedBox(height: 15),
                  const Text(
                    'Advance  - 5W-20',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.advance5W20),
                  const SizedBox(height: 15),
                  const Text(
                    'Advance  - 5W-30',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(textValue: data.advance5W30),
                  const SizedBox(height: 15),
                  const Text(
                    "Day and Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  OverviewValueWidget(
                    textValue: DateFormat("dd/MM/yyyy-h:m a").format(
                      data.date.toDate(),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ));
  }
}

class OverviewValueWidget extends StatelessWidget {
  const OverviewValueWidget({
    super.key,
    required this.textValue,
  });

  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromARGB(255, 239, 239, 239),
      ),
      height: 44,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            textValue,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
