import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/constant/enums.dart';
import '../../../../core/controllers/user_controller.dart';
import '../../../../core/helpers/functions/functions.dart';
import '../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/references.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/custom_widget.dart';
import '../../../../core/widgets/others.dart';
import '../../../../core/widgets/profile_delete_button.dart';
import '../../../../core/widgets/tiles.dart';
import '../../../../models/notifications_model.dart';
import '../../../../models/store_model.dart';
import '../../../splash/views/select_user_screen.dart';
import '../agents/view/agents_screen.dart';
import '../notifications/notification_controller.dart';
import '../notifications/notifications_screen.dart';
import '../overview/overview_screen.dart';
import '../profile/admin_profile_controller.dart';
import '../profile/admin_profile_screen.dart';
import '../warehouse_manager/views/all_managers.dart';
import '../warehouse_stock/screens/admin_warehouse_stock_1.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      drawer: _drawer(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Home",
          style: TextStyle(color: AppColor.red),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text("Admin"),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const AdminProfileScreen());
                  },
                  child: Stack(
                    children: [
                      GetBuilder<UserController>(
                        init: UserController(),
                        builder: (_) {
                          return SizedBox(
                            height: 48,
                            width: 48,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Constant.user!.imgUrl.isNotEmpty
                                  ? Image.network(
                                      Constant.user!.imgUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      decoration: const BoxDecoration(
                                          color: AppColor.red),
                                      child: Center(
                                        child: Text(
                                          getInitialCharacters(
                                            "${Constant.user!.firstName} ${Constant.user!.lastName}",
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      const Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 7,
                            child: CircleAvatar(
                              backgroundColor: AppColor.green,
                              radius: 5,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: Get.height * .25,
            child: PageView(
              onPageChanged: homeController.onDashboardChange,
              scrollDirection: Axis.horizontal,
              children: homeController.dashboards,
            ),
          ),
          SizedBox(
            height: 30,
            child: GetBuilder<HomeController>(
              builder: (_) => ListView.builder(
                shrinkWrap: true,
                itemCount: homeController.dashboards.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: homeController.dashboardIndex == index
                        ? AppColor.red
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Notifications",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.red,
            ),
          ),
          const SizedBox(height: 14),
          GetBuilder<HomeController>(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => homeController.changeTab("pending"),
                    child: Text(
                      "Pending",
                      style: homeController.notificationSelectedTab == "pending"
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: () => homeController.changeTab("approved"),
                    child: Text(
                      "Approval",
                      style:
                          homeController.notificationSelectedTab == "approved"
                              ? const TextStyle(fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                    onTap: () => homeController.changeTab("decline"),
                    child: Text(
                      "Decline",
                      style: homeController.notificationSelectedTab == "decline"
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ],
              );
            },
          ),
          const Divider(),
          Expanded(
            child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (_) {
                return _notifications(homeController.notificationSelectedTab);
              },
            ),
          ),
          const SizedBox(height: 12),
          CustomButtonWidget(
            onTap: () {
              Get.to(() => const NotificationsScreen(), arguments: {
                "tabName": homeController.notificationSelectedTab
              });
            },
            title: "See more",
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.15, vertical: Get.height * 0.01),
          ),
          const SizedBox(height: 30),
        ],
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
            final noti = notifications[index];
            return CustomListTileWidget(
              title: "${noti.firstName} ${noti.lastName} | ",
              role: "${noti.role.capitalize}",
              imgurl: noti.imgUrl,
              subtitle: noti.email,
              accpet: status != UserStatus.approved.name
                  ? () => NotificationController().accept(
                        UserData(
                          context: context,
                          notification: notifications[index],
                          status: status,
                          userEmail: noti.email,
                          userName: "${noti.firstName} ${noti.lastName}",
                        ),
                      )
                  : null,
              reject: status != UserStatus.decline.name
                  ? () => NotificationController().reject(
                        UserData(
                          context: context,
                          notification: notifications[index],
                          status: status,
                          userEmail: noti.email,
                          userName: "${noti.firstName} ${noti.lastName}",
                        ),
                      )
                  : null,
            );
          },
        );
      },
    );
  }
}

class AgentDashboardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool totalCostEnable;
  const AgentDashboardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.totalCostEnable});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SvgPicture.asset(Assets.logoSvg),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: totalCostEnable
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                Column(
                    crossAxisAlignment: totalCostEnable
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Text(
                        subTitle,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        title,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ]),
                Visibility(
                  visible: totalCostEnable,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection(Collection.storeData.name)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.size == 0) {
                              return const Text(
                                "\$0",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              );
                            }
                            double totalcost = 0.0;
                            for (var element in (snapshot.data!.docs
                                .map((doc) => StoreModel.fromMap(doc.data()))
                                .toList())) {
                              totalcost += element.comission;
                            }
                            return Text(
                              "\$" "$totalcost",
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            );
                          }),
                      const Text(
                        "Total cost spend",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Drawer _drawer(BuildContext context) {
  return Drawer(
    child: Material(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColor.red,
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 33),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 8, top: 8, bottom: 8),
                            child: Icon(Icons.clear, color: Colors.white),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => const AdminProfileScreen());
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "edit",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<AdminProfileController>(
                      init: AdminProfileController(),
                      builder: (_) {
                        return CircleImage(
                          size: 104.0,
                          fontSize: 35.0,
                          heading:
                              "${Constant.user!.firstName} ${Constant.user!.lastName}",
                          imageUrl: Constant.user!.imgUrl,
                        );
                      }),
                  const SizedBox(height: 10),
                  Text(
                    "${Constant.user!.firstName} ${Constant.user!.lastName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Text(
                      Constant.user!.email,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          TapTileWidget(
            onTap: () => Get.back(),
            iconRef: Assets.home,
            title: "Home",
          ),
          const SizedBox(height: 10),
          TapTileWidget(
            onTap: () {
              Get.back();
              Get.to(() => const OverviewScreen());
            },
            iconRef: Assets.overview,
            title: "Overview",
          ),
          const SizedBox(height: 10),
          TapTileWidget(
            onTap: () {
              Get.back();
              Get.to(() => const AgentsScreen());
            },
            iconRef: Assets.agent,
            title: "Agents",
          ),
          const SizedBox(height: 10),
          TapTileWidget(
            onTap: () {
              Get.back();
              Get.to(() => const NotificationsScreen(),
                  arguments: {"tabName": "pending"});
            },
            iconRef: Assets.notification,
            title: "Notifications",
          ),
          const SizedBox(height: 10),
          TapTileWidget(
            onTap: () {
              Get.back();
              Get.to(() => const AllManagersScreen());
            },
            iconRef: Assets.manager,
            title: "Warehouse Managers",
          ),
          const SizedBox(height: 10),
          TapTileWidget(
            onTap: () {
              Get.back();
              Get.to(() => const AdminWarehouseStocksScreen1());
            },
            iconRef: Assets.warehouse,
            title: "Warehouse Stock",
          ),
          const SizedBox(height: 10),
          const ProfileDeleteButton(),
          const Spacer(),
          SafeArea(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: AppButton(
              onTap: () => _logout(context),
              title: "Logout",
            ),
          )),
          const SizedBox(height: 10),
        ],
      ),
    ),
  );
}

void _logout(BuildContext context) {
  showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Log out"),
            content: const SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("Are you sure you want to log out?"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: const Text(
                  "Log out",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Get.back();
                  SignOutService().signOut();
                  Get.offAll(() => const SelectUserScreen());
                  Constant.user = null;
                },
              ),
            ]);
      });
}
