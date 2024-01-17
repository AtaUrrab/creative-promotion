import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/enums.dart';
import 'home_screen.dart';

class HomeController extends GetxController {
  String notificationSelectedTab = "pending";
  int dashboardIndex = 0;

  void changeTab(String status) {
    notificationSelectedTab = status;
    update();
  }

  void onDashboardChange(int value) {
    dashboardIndex = value;
    update();
  }

  List<Widget> dashboards = [
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(Collection.users.name)
            .where("role", isEqualTo: Role.agent.name)
            .where("status", isEqualTo: UserStatus.approved.name)
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return AgentDashboardWidget(
            title: "No. of Agents",
            subTitle: "${snapshot.data?.docs.length ?? 0}",
            totalCostEnable: true,
          );
        }),
    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(Collection.users.name)
            .where("role", isEqualTo: Role.manager.name)
            .where("status", isEqualTo: UserStatus.approved.name)
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return AgentDashboardWidget(
            title: "No. of Managers",
            subTitle: "${snapshot.data?.docs.length ?? 0}",
            totalCostEnable: false,
          );
        }),
  ];
}
