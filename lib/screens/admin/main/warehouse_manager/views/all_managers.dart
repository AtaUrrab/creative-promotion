import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/screens/admin/main/warehouse_manager/controllers/warehouse_manager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/widgets/cards.dart';
import '../../../../../core/widgets/textfield.dart';
import '../../../../../models/user_model.dart';
import 'warehouse_manager_detail.dart';

class AllManagersScreen extends StatelessWidget {
  const AllManagersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WarehouseManagerController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Warehouse Managers",
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
                  .where("role", isEqualTo: Role.manager.name)
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
                controller.totalManagers = [];
                controller.filterManagers = [];
                controller.totalManagers = snapshot.data!.docs
                    .map((doc) => UserModel.fromMap(doc.data()))
                    .toList();

                controller.filterManagers.addAll(controller.totalManagers);

                return Expanded(
                  child: GetBuilder<WarehouseManagerController>(
                    builder: (_) {
                      return GridView.builder(
                          itemCount: controller.filterManagers.length,
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
                            final manager = controller.filterManagers;
                            return AgentsCardWidget(
                                imgUrl: manager[index].imgUrl,
                                name:
                                    "${manager[index].firstName} ${manager[index].lastName}",
                                email: manager[index].email,
                                showIcon: manager[index].status ==
                                    UserStatus.decline.name,
                                onTap: () {
                                  Get.to(() => const WarehouseManagerDetail(),
                                      arguments: {
                                        "managerModel": manager[index],
                                      });
                                });
                          });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
