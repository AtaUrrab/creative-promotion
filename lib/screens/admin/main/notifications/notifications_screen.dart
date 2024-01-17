import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:creativepromotion/core/constant/enums.dart';
import 'package:creativepromotion/screens/admin/main/notifications/notification_controller.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/tiles.dart';
import '../../../../models/notifications_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<NotificationController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    notificationController.status.length,
                    (int index) {
                      return ChoiceChip(
                        label:
                            Text(notificationController.status[index].status),
                        selected:
                            notificationController.notificationSelectedTab ==
                                notificationController.status[index].status,
                        selectedColor: AppColor.red,
                        labelStyle: const TextStyle(color: Colors.white),
                        onSelected: (bool selected) {
                          notificationController.notificationSelectedTab =
                              notificationController.status[index].status;
                          notificationController.update();
                        },
                      );
                    },
                  ).toList(),
                ),
                Expanded(
                    child: _notifications(
                  notificationController.notificationSelectedTab,
                )),
              ],
            );
          },
        ),
      ),
    );
  }

  StreamBuilder _notifications(String status) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection(Collection.notifications.name)
          .where("status", isEqualTo: status)
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.size == 0) {
          return const Center(
            child: Text(
              "No Notfications!",
              style: TextStyle(fontSize: 16.0),
            ),
          );
        }
        final List<NotificationsModel> notifications = snapshot.data!.docs
            .map((doc) => NotificationsModel.fromMap(doc.data()))
            .toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            final notificationIndex = notifications[index];
            return CustomListTileWidget(
              title:
                  "${notificationIndex.firstName} ${notificationIndex.lastName} | ",
              imgurl: notificationIndex.imgUrl,
              subtitle: notificationIndex.email,
              role: "${notificationIndex.role.capitalize}",
              accpet: status != UserStatus.approved.name
                  ? () => NotificationController().accept(
                        UserData(
                            context: context,
                            notification: notifications[index],
                            status: status,
                            userEmail: notificationIndex.email,
                            userName:
                                "${notificationIndex.firstName} ${notificationIndex.lastName}"),
                      )
                  : null,
              reject: status != UserStatus.decline.name
                  ? () => NotificationController().reject(
                        UserData(
                            context: context,
                            notification: notifications[index],
                            status: status,
                            userEmail: notificationIndex.email,
                            userName:
                                "${notificationIndex.firstName} ${notificationIndex.lastName}"),
                      )
                  : null,
            );
          },
        );
      },
    );
  }
}

class UserData {
  final NotificationsModel notification;
  final String status;
  final BuildContext context;
  final String userName;
  final String userEmail;

  UserData({
    required this.notification,
    required this.status,
    required this.context,
    required this.userName,
    required this.userEmail,
  });
}
