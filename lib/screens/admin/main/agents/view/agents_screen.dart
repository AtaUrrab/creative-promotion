import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/models/user_model.dart';
import 'package:creativepromotion/screens/admin/main/agents/controller/agent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/widgets/cards.dart';
import '../../../../../core/widgets/textfield.dart';
import 'agents_detail_screen.dart';

class AgentsScreen extends StatelessWidget {
  const AgentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgentController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Agents",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SearchTextFieldWidget(
                controller: controller.search,
                onChanged: controller.onSearch,
                hintText: "Search",
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(Collection.users.name)
                    .where("role", isEqualTo: "agent")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.size == 0) {
                    return const Center(
                      child: Text(
                        "No data Available!",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    );
                  }
                  controller.totalAgents = [];
                  controller.filterAgents = [];
                  controller.totalAgents = snapshot.data!.docs
                      .map((doc) => UserModel.fromMap(doc.data()))
                      .toList();
                  controller.filterAgents.addAll(controller.totalAgents);
                  return Expanded(
                    child: GetBuilder<AgentController>(
                      builder: (_) {
                        return GridView.builder(
                            itemCount: controller.filterAgents.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 210,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              final agents = controller.filterAgents;
                              return AgentsCardWidget(
                                imgUrl: agents[index].imgUrl,
                                name:
                                    "${agents[index].firstName} ${agents[index].lastName}",
                                email: agents[index].email,
                                showIcon: agents[index].status ==
                                    UserStatus.decline.name,
                                onTap: () => Get.to(
                                    () => const AgentDetailScreen(),
                                    arguments: {
                                      "userModel": agents[index],
                                    }),
                              );
                            });
                      },
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }
}
