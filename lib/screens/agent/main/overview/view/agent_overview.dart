import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/constant/enums.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/others.dart';
import '../../../../../core/widgets/textfield.dart';
import '../controller/agent_overview_controller.dart';

class AgentOverviewScreen extends StatelessWidget {
  const AgentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentOverviewController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Overview",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<AgentOverviewController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleImage(
                    heading:
                        "${Constant.user!.firstName} ${Constant.user!.lastName}",
                    imageUrl: Constant.user!.imgUrl,
                    size: 100,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "${Constant.user!.firstName} ${Constant.user!.lastName}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                Constant.user!.email,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection(Collection.storeData.name)
                      .where("addById", isEqualTo: Constant.user!.uid)
                      .orderBy("createdAt", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "\$"
                              "${Constant.user!.totalCommision}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Total Earnings",
                              style: TextStyle(
                                letterSpacing: -0.5,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${(snapshot.data?.docs.length ?? 0)}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Covered Stores",
                              style: TextStyle(
                                letterSpacing: -0.5,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 20),
              const Divider(color: AppColor.red),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Select Dates:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller:
                    TextEditingController(text: controller.firstDateText),
                onTap: () => controller.firstDateMethod(context),
              ),
              const SizedBox(height: 10),
              const Text(
                "To",
                style: TextStyle(fontSize: 18),
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
                  onTap: controller.isFirstSelect && controller.isSecondSelect
                      ? () {
                          controller.onSearchFunction();
                        }
                      : null,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
