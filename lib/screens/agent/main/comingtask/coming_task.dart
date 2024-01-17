import 'package:creativepromotion/core/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/colors.dart';
import 'coming_task_controller.dart';

class TodoTaskScreen extends StatelessWidget {
  const TodoTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoTaskController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "To Do",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<TodoTaskController>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Assign Date:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        DateFormat("EEE, dd/MM/yyyy")
                            .format(controller.assignDate),
                        style: const TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Due Date:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        DateFormat("EEE, dd/MM/yyyy")
                            .format(controller.dueDate),
                        style: const TextStyle(
                          color: AppColor.red,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Stores List",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  if (controller.isFetched == true)
                    ListView.builder(
                      itemCount: controller.storesListModel.storesList!.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(controller
                                          .storesListModel.storesList![i])),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            controller.onClickedCheckMethod(i),
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () =>
                                            controller.onClickedCrossMethod(i),
                                        child: const Icon(
                                          Icons.cancel_rounded,
                                          color: AppColor.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            controller.storeIndex != i ||
                                    controller.isClickedCross == false
                                ? const Offstage()
                                : Form(
                                    key: controller.formKey,
                                    child: TextFieldWidget(
                                        hintText: "Comment (Reason)",
                                        isSnableMaxLines: true,
                                        maxlines: 5,
                                        controller: controller.resonText,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please enter a reason";
                                          }
                                          return null;
                                        }),
                                  ),
                            controller.storeIndex != i ||
                                    controller.isClickedCross == false
                                ? const Offstage()
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: MaterialButton(
                                      color: AppColor.red,
                                      onPressed: () =>
                                          controller.onSaveButton(i),
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
