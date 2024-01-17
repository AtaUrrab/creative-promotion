import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/others.dart';
import '../../../../../core/widgets/textfield.dart';
import '../controller/agent_controller.dart';
import '../controller/agnet_detail_controller.dart';

class AgentDetailScreen extends StatelessWidget {
  const AgentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final agentController = Get.put(AgentDetailController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Agent Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GetBuilder<AgentDetailController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleImage(
                        heading:
                            "${agentController.agentModel?.firstName} ${agentController.agentModel?.lastName}",
                        imageUrl: agentController.agentModel?.imgUrl,
                        size: 100,
                        fontSize: 26,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${agentController.agentModel?.firstName} ${agentController.agentModel?.lastName}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${agentController.agentModel?.email}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            "${agentController.agentModel?.phone}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "\$"
                          "${agentController.agentModel?.commision}",
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Commision",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection(Collection.storeData.name)
                                .where("addById",
                                    isEqualTo: agentController.agentModel?.uid)
                                .orderBy("createdAt")
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Text(
                                "${snapshot.data?.docs.length ?? 0}",
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                          const Text(
                            "Covered Stores",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(children: [
                        Text(
                          "\$"
                          "${agentController.agentModel?.totalCommision}",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Total Earnings",
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Select Dates:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: TextEditingController(
                        text: agentController.firstDateText),
                    onTap: () => agentController.firstDateMethod(context),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "To",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: TextEditingController(
                        text: agentController.secondDateText),
                    onTap: () => agentController.secondDateMethod(context),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      title: "Search ",
                      onTap: agentController.isFirstSelect &&
                              agentController.isSecondSelect
                          ? () {
                              agentController.onSearchFunction();
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Actions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MaterialButton(
                              onPressed: () =>
                                  Get.put(AgentController()).changeComission(
                                context,
                                agentController.agentModel?.uid ?? "",
                                agentController.agentModel?.commision ?? 0.0,
                              ),
                              color: Colors.blue,
                              child: const Text("Change commission",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            MaterialButton(
                              onPressed: () => agentController
                                          .agentModel?.status !=
                                      UserStatus.decline.name
                                  ? _restrictAgent(context,
                                      agentController.agentModel?.uid ?? "")
                                  : _unRestrictAgent(context,
                                      agentController.agentModel?.uid ?? ""),
                              color: agentController.agentModel?.status !=
                                      UserStatus.decline.name
                                  ? Colors.red
                                  : Colors.green,
                              child: Text(
                                  agentController.agentModel?.status !=
                                          UserStatus.decline.name
                                      ? "Restricted user"
                                      : "Unrestricted user",
                                  style: const TextStyle(color: Colors.white)),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _restrictAgent(BuildContext context, String uid) {
    final controller = Get.put(AgentController());
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Restricted agent'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to restrict this agent?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Restrict',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    controller.restrictAgent(uid);
                  },
                ),
              ]);
        });
  }

  _unRestrictAgent(BuildContext context, String uid) {
    final controller = Get.put(AgentController());
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Unrestricted agent'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to unrestrict this agent?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text(
                    'Unrestricted',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    controller.unRestrictAgent(uid);
                  },
                ),
              ]);
        });
  }
}
