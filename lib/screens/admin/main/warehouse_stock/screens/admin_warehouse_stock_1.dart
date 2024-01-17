import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/enums.dart';
import 'package:creativepromotion/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/cards.dart';
import '../controllers/admin_stocks_controller.dart';

class AdminWarehouseStocksScreen1 extends StatelessWidget {
  const AdminWarehouseStocksScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminWarehouseStockController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.logo,
                    height: 150,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Stock Overview",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
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
                          "No Stock Overview Available!",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    }
                    final List<UserModel> managers = snapshot.data!.docs
                        .map((doc) => UserModel.fromMap(doc.data()))
                        .toList();
                    controller.uid = managers.first.uid;

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: managers.length,
                      itemBuilder: (_, index) =>
                          GetBuilder<AdminWarehouseStockController>(
                        builder: (_) {
                          final manager = managers[index];
                          return StockCardWidget(
                            onTap: () {
                              controller.onTap(manager.uid);
                            },
                            title: manager.manager!.name,
                            isSelected: controller.uid == manager.uid,
                          );
                        },
                      ),
                      separatorBuilder: (_, i) => const SizedBox(height: 20),
                    );
                  }),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
