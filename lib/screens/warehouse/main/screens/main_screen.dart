import 'package:creativepromotion/core/utils/colors.dart';
import 'package:creativepromotion/screens/warehouse/main/controllers/main_controller.dart';
import 'package:creativepromotion/screens/warehouse/main/screens/profile/controllers/manager_profile_controller.dart';
import 'package:creativepromotion/screens/warehouse/main/screens/profile/views/managerprofile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../core/utils/references.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/cards.dart';
import '../../../../core/widgets/others.dart';
import '../../../../core/widgets/profile_delete_button.dart';
import '../../../../core/widgets/tiles.dart';
import '../../../splash/views/select_user_screen.dart';
import 'overview/screens/warehouse_overview.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stocksController = Get.put(MainController());
    return Scaffold(
      drawer: _drawer(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
            const SizedBox(height: 15),
            const Text.rich(TextSpan(children: [
              TextSpan(
                text: "Good Day, ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Manager!",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stocksController.stocks1.length,
              itemBuilder: (_, index) => GetBuilder<MainController>(
                builder: (controller) {
                  final stock = controller.stocks1[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: StockCardWidget(
                      isDisable: true,
                      onTap: () {
                        controller.onTap(stock.value);
                        controller.continueMethod(controller.selectedStock);
                      },
                      title: stock.name,
                      isSelected: stock.value == controller.selectedStock,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
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
                    Constant.user = null;
                    Get.offAll(() => const SelectUserScreen());
                  },
                ),
              ]);
        });
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
                              Get.back();
                              Get.to(() => const ProfileView());
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "edit",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<ManagerProfileController>(
                      init: ManagerProfileController(),
                      builder: (_) {
                        return CircleImage(
                          size: 104.0,
                          fontSize: 35.0,
                          heading:
                              "${Constant.user!.firstName} ${Constant.user!.lastName}",
                          imageUrl: Constant.user!.imgUrl,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${Constant.user!.firstName} ${Constant.user!.lastName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      Constant.user!.email,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
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
                Get.to(() => const ProfileView());
              },
              title: "Profile Edit",
              iconRef: Assets.profileEdit,
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
}
