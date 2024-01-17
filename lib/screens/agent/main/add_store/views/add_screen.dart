import 'package:creativepromotion/screens/agent/main/profile/agent_profile_screen.dart'
    as agent;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/services/firebase/auth/firebase_auth/firebase_auth.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/others.dart';
import '../../../../../core/widgets/profile_delete_button.dart';
import '../../../../../core/widgets/textfield.dart';
import '../../../../../core/widgets/tiles.dart';
import '../../../../../models/store_model.dart';
import '../../../../splash/views/select_user_screen.dart';
import '../../comingtask/coming_task.dart';
import '../../overview/view/agent_overview.dart';
import '../../warehouse/screens/warehouse_stock_1.dart';
import '../controllers/add_controller.dart';

class AddScreen extends StatelessWidget {
  final StoreModel? store;
  const AddScreen({super.key, this.store});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());
    return Scaffold(
      drawer: Drawer(
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
                              onTap: () =>
                                  Get.to(() => const agent.ProfileScreen()),
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
                      GetBuilder<AddController>(
                          init: AddController(),
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
                      Text(
                        Constant.user!.email,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
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
                  Get.to(() => const TodoTaskScreen());
                },
                title: "Coming Task",
                iconRef: Assets.weeklyOverview,
              ),
              const SizedBox(height: 10),
              TapTileWidget(
                onTap: () {
                  Get.back();
                  Get.to(() => const WarehouseStocksScreen1());
                },
                iconRef: Assets.warehouse,
                title: "Warehouse",
              ),
              const SizedBox(height: 10),
              TapTileWidget(
                onTap: () {
                  Get.back();
                  Get.to(() => const AgentOverviewScreen());
                },
                iconRef: Assets.salesOverview,
                title: "Overview",
              ),
              const SizedBox(height: 10),
              TapTileWidget(
                onTap: () => Get.to(() => const agent.ProfileScreen()),
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
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add your data",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.firstFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  Assets.logo,
                  height: 150,
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  hintText: 'Store Name',
                  controller: controller.storeName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Store Phone',
                  controller: controller.storePhone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!value.isPhoneNumber) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Store Address',
                  controller: controller.storeAddress,
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  hintText: 'Email Address',
                  controller: controller.storeEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!value.isEmail) {
                      return 'Please enter correct email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                const Text(
                  "Your Designation",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 20),
                GetBuilder<AddController>(
                  builder: (_) {
                    return Column(
                      children: [
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Owner"),
                          value: "Owner",
                          groupValue: controller.designation,
                          onChanged: (value) {
                            controller.designation = value.toString();
                            controller.update();
                          },
                        ),
                        controller.designation == "Owner"
                            ? Column(
                                children: [
                                  TextFieldWidget(
                                    hintText: "Name",
                                    controller: controller.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFieldWidget(
                                    hintText: "Email",
                                    controller: controller.email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if (!value.isEmail) {
                                        return "Plese Enter Valid Email";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : const Offstage(),
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Manager"),
                          value: "Manager",
                          groupValue: controller.designation,
                          onChanged: (value) {
                            controller.designation = value.toString();
                            controller.update();
                          },
                        ),
                        controller.designation == "Manager"
                            ? Column(
                                children: [
                                  TextFieldWidget(
                                    hintText: "Name",
                                    controller: controller.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFieldWidget(
                                    hintText: "Email",
                                    controller: controller.email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if (!value.isEmail) {
                                        return "Plese Enter Valid Email";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : const Offstage(),
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Decision Maker"),
                          value: "Decision Maker",
                          groupValue: controller.designation,
                          onChanged: (value) {
                            controller.designation = value.toString();
                            controller.update();
                          },
                        ),
                        controller.designation == "Decision Maker"
                            ? Column(
                                children: [
                                  TextFieldWidget(
                                    controller: controller.name,
                                    hintText: "Name",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFieldWidget(
                                    hintText: "Email",
                                    controller: controller.email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      if (!value.isEmail) {
                                        return "Plese Enter Valid Email";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : const Offstage(),
                        RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text("Other"),
                          value: "Other",
                          groupValue: controller.designation,
                          onChanged: (value) {
                            controller.designation = value.toString();
                            controller.update();
                          },
                        ),
                        controller.designation == "Other"
                            ? Column(
                                children: [
                                  TextFieldWidget(
                                    hintText: "Name",
                                    controller: controller.name,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldWidget(
                                    hintText: "Email",
                                    controller: controller.email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              )
                            : const Offstage()
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
                AppButton(
                  color: AppColor.red,
                  titleStyle: const TextStyle(color: Colors.white),
                  onTap: controller.add,
                  title: "Continue",
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
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
              title: const Text('Logout'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Do you really want to log out?'),
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
                    'Log out',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    SignOutService().signOut();
                    Constant.user = null;
                    Get.offAll(() => const SelectUserScreen());
                  },
                ),
              ]);
        });
  }
}
