import 'package:creativepromotion/core/constant/constant.dart';
import 'package:creativepromotion/core/widgets/button.dart';
import 'package:creativepromotion/core/widgets/textfield.dart';
import 'package:creativepromotion/screens/warehouse/main/screens/supply_stock/controllers/supply_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/references.dart';
import '../../../../../../core/utils/strings.dart';
import '../../../../../../core/widgets/selcted_category_widget.dart';

class SupplyStockScreen extends StatelessWidget {
  const SupplyStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupplyController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Supply Stock",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
                key: controller.formkey,
                child: GetBuilder<SupplyController>(builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          Assets.logo,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Warehouse Name: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldWidget(
                        enabled: false,
                        readyOnly: true,
                        controller: TextEditingController(
                            text: Constant.user!.manager!.name),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Agent Name: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldWidget(
                        controller: controller.agentName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Plese Fill this field";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Email Address: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldWidget(
                        controller: controller.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Plese Enter Your Email Here";
                          }
                          if (!value.isEmail) {
                            return "Plese Enter Valid Email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Supplied Stock: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Section Fully Syncthethic - OW-20
                      SelectCategoryWidget(
                        title: 'Full Synthethic  - OW-20',
                        isSelectedBox: controller.isSyncthethicSelectedOW20,
                        onTap: () {
                          controller.fieldFullySyntyheticOW20.requestFocus();
                          controller.isSyncthethicSelectedOW20 =
                              !controller.isSyncthethicSelectedOW20;
                          controller.fullySyntyheticOW20.clear();
                          controller.update();
                        },
                      ),
                      controller.isSyncthethicSelectedOW20 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isSyncthethicSelectedOW20 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.fullySyntyheticOW20,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldFullySyntyheticOW20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }

                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "Full Synthethic - OW-20");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section Fully Syncthethic - 5W-20
                      SelectCategoryWidget(
                        title: 'Full Synthethic  - 5W-20',
                        isSelectedBox: controller.isSyncthethicSelected5W20,
                        onTap: () {
                          controller.fieldFullySyntyheticOW20.unfocus();
                          controller.fieldFullySyntyhetic5W20.requestFocus();
                          controller.isSyncthethicSelected5W20 =
                              !controller.isSyncthethicSelected5W20;
                          controller.fullySyntyhetic5W20.clear();
                          controller.update();
                        },
                      ),
                      controller.isSyncthethicSelected5W20 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isSyncthethicSelected5W20 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.fullySyntyhetic5W20,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldFullySyntyhetic5W20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "Full Synthethic - 5W-20");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section Fully Syncthethic - 5W-30
                      SelectCategoryWidget(
                        title: 'Full Synthethic  - 5W-30',
                        isSelectedBox: controller.isSyncthethicSelected5W30,
                        onTap: () {
                          controller.fieldFullySyntyhetic5W20.unfocus();
                          controller.fieldFullySyntyhetic5W30.requestFocus();
                          controller.isSyncthethicSelected5W30 =
                              !controller.isSyncthethicSelected5W30;
                          controller.fullySyntyhetic5W30.clear();
                          controller.update();
                        },
                      ),
                      controller.isSyncthethicSelected5W30 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isSyncthethicSelected5W30 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.fullySyntyhetic5W30,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldFullySyntyhetic5W30,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "Full Synthethic - 5W-30");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section High Mileage  - OW-20
                      SelectCategoryWidget(
                        title: 'High Mileage  - OW-20',
                        isSelectedBox: controller.isMileageSelectedOW20,
                        onTap: () {
                          controller.fieldFullySyntyhetic5W30.unfocus();
                          controller.fieldHighMileageOW20.requestFocus();
                          controller.isMileageSelectedOW20 =
                              !controller.isMileageSelectedOW20;
                          controller.highMileageOW20.clear();
                          controller.update();
                        },
                      ),
                      controller.isMileageSelectedOW20 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isMileageSelectedOW20 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.highMileageOW20,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldHighMileageOW20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "High Mileage - OW-20");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section High Mileage  - 5W-20
                      SelectCategoryWidget(
                        title: 'High Mileage  - 5W-20',
                        isSelectedBox: controller.isMileageSelected5W20,
                        onTap: () {
                          controller.fieldHighMileageOW20.unfocus();
                          controller.fieldHighMileage5W20.requestFocus();
                          controller.isMileageSelected5W20 =
                              !controller.isMileageSelected5W20;
                          controller.highMileage5W20.clear();
                          controller.update();
                        },
                      ),
                      controller.isMileageSelected5W20 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isMileageSelected5W20 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.highMileage5W20,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldHighMileage5W20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "High Mileage - 5W-20");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section High Mileage  - 5W-30
                      SelectCategoryWidget(
                        title: 'High Mileage  - 5W-30',
                        isSelectedBox: controller.isMileageSelected5W30,
                        onTap: () {
                          controller.fieldHighMileage5W20.unfocus();
                          controller.fieldHighMileage5W30.requestFocus();
                          controller.isMileageSelected5W30 =
                              !controller.isMileageSelected5W30;
                          controller.highMileage5W30.clear();
                          controller.update();
                        },
                      ),
                      controller.isMileageSelected5W30 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isMileageSelected5W30 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.highMileage5W30,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldHighMileage5W30,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "High Mileage - 5W-30");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section Advance  - OW-20
                      SelectCategoryWidget(
                        title: 'Advance  - OW-20',
                        isSelectedBox: controller.isAdvanceSelectedOW20,
                        onTap: () {
                          controller.fieldHighMileage5W30.unfocus();
                          controller.fieldAdvanceOW20.requestFocus();
                          controller.isAdvanceSelectedOW20 =
                              !controller.isAdvanceSelectedOW20;
                          controller.advanceOW20.clear();
                          controller.update();
                        },
                      ),
                      controller.isAdvanceSelectedOW20 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isAdvanceSelectedOW20 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.advanceOW20,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldAdvanceOW20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "Advance - OW-20");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),

                      //Section Advance  - 5W-20
                      SelectCategoryWidget(
                        title: 'Advance  - 5W-20',
                        isSelectedBox: controller.isAdvanceSelected5W20,
                        onTap: () {
                          controller.fieldAdvanceOW20.unfocus();
                          controller.fieldAdvance5W20.requestFocus();
                          controller.isAdvanceSelected5W20 =
                              !controller.isAdvanceSelected5W20;
                          controller.advance5W20.clear();
                          controller.update();
                        },
                      ),
                      controller.isAdvanceSelected5W20 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isAdvanceSelected5W20 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.advance5W20,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldAdvance5W20,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "Advance - 5W-20");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),
                      //Section Advance  - 5W-30
                      SelectCategoryWidget(
                        title: 'Advance  - 5W-30',
                        isSelectedBox: controller.isAdvanceSelected5W30,
                        onTap: () {
                          controller.fieldAdvance5W20.unfocus();
                          controller.fieldAdvance5W30.requestFocus();
                          controller.isAdvanceSelected5W30 =
                              !controller.isAdvanceSelected5W30;
                          controller.advance5W30.clear();
                          controller.update();
                        },
                      ),
                      controller.isAdvanceSelected5W30 == true
                          ? const SizedBox(height: 10)
                          : const Offstage(),
                      controller.isAdvanceSelected5W30 == true
                          ? TextFieldWidget(
                              hintText: "Quantity",
                              controller: controller.advance5W30,
                              keyboardType: TextInputType.number,
                              focusNode: controller.fieldAdvance5W30,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppString.emptyError;
                                }
                                if (!value.isNum) {
                                  return AppString.digitErorr;
                                }
                                try {
                                  final result = controller.stocksModelList
                                      .firstWhere((element) =>
                                          element.catagory ==
                                          "Advance - 5W-30");
                                  if (int.parse(value) > result.quantity!) {
                                    return 'Available Inventory ${result.quantity}';
                                  }
                                } catch (e) {
                                  return AppString.inventoryErorr;
                                }
                                return null;
                              },
                            )
                          : const Offstage(),
                      const SizedBox(height: 15),

                      //Section Date and Time
                      const Text(
                        "Date and Time: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFieldWidget(
                        enabled: false,
                        readyOnly: true,
                        controller: TextEditingController(
                            text: DateFormat("dd/MM/yyyy - h:m a")
                                .format(controller.dateTime)),
                      ),
                      const SizedBox(height: 30),

                      //Section Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          onTap: () => controller.onSubmit(),
                          title: "Submit",
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  );
                })),
          ),
        ));
  }

  // void _datePick(BuildContext context, SupplyController controller) async {
  //   DateTime? date = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2021),
  //     lastDate: DateTime(2025),
  //   );
  //   if (date == null) return;
  //   TimeOfDay? time;
  //   if (context.mounted) {
  //     time = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.now(),
  //     );
  //   }
  //   if (time == null) return;
  //   date.copyWith(minute: time.minute, hour: time.hour);
  //   controller.date.text = DateFormat("dd/MM/yyyy-h:m a").format(date);
  //   controller.dateTime = date;
  // }
}
