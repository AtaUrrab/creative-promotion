import 'package:creativepromotion/core/utils/colors.dart';
import 'package:creativepromotion/core/widgets/textfield.dart';
import 'package:creativepromotion/screens/warehouse/main/screens/update_stock/update_stocks_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/button.dart';

class UpdateStockScreen extends StatelessWidget {
  const UpdateStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateStocksController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<UpdateStocksController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.logo,
                  height: 140,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Update Stock",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mobil Oil Category :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.red, width: 3),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: Get.width,
                        height: 55,
                        child: DropdownButton(
                          underline: const Offstage(),
                          isExpanded: true,
                          value: controller.selectedMoboOilCategory,
                          onChanged: (value) {
                            controller.selectedMoboOilCategory = value ?? '';
                            controller.update();
                          },
                          items: controller.categoryList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: SizedBox(
                                width: Get.width,
                                height: Get.height,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Text(value),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Mobil Oil Quantity :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 55,
                        child: TextFieldWidget(
                          hintText: "Quantity",
                          controller: controller.moboOilQuantity,
                          keyboardType: TextInputType.number,
                          borderSide:
                              const BorderSide(color: AppColor.red, width: 3),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: double.infinity,
          child: GetBuilder<UpdateStocksController>(
            builder: (controller) {
              return AppButton(
                onTap: () => controller.onClick(),
                title: "Update",
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
