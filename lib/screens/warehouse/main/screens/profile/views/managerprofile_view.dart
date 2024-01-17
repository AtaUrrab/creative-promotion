import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/constant/constant.dart';
import '../../../../../../core/widgets/button.dart';
import '../../../../../../core/widgets/cards.dart';
import '../../../../../../core/widgets/others.dart';
import '../../../../../../core/widgets/textfield.dart';
import '../controllers/manager_profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManagerProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                GetBuilder<ManagerProfileController>(
                  builder: (_) => CircleImage(
                    heading:
                        "${Constant.user!.firstName} ${Constant.user!.lastName}",
                    imgAsset: controller.profileIMG,
                    imageUrl: Constant.user!.imgUrl,
                    fontSize: 20,
                    onTap: () => controller.profileImage(context),
                    size: 100,
                    isEditScreen: true,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Upload Your Image",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  enabled: false,
                  readyOnly: true,
                  controller: controller.firstName,
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  enabled: false,
                  readyOnly: true,
                  controller: controller.lastName,
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  enabled: false,
                  readyOnly: true,
                  controller: controller.email,
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  controller: controller.phone,
                  hintText: "Phone No:",
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
                const SizedBox(height: 18),
                TextFieldWidget(
                  controller: controller.warehouseName,
                  hintText: "Warehouse Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  controller: controller.warehouseAddress,
                  hintText: "Warehouse Address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  controller: controller.warehouseNo,
                  hintText: "Warehouse Phone Number:",
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
                const SizedBox(height: 18),
                TextFieldWidget(
                  controller: controller.warehouseSize,
                  hintText: "Warehouse Size (Sq Feet)",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!value.isNum) {
                      return 'Please enter valid size';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                TextFieldWidget(
                  controller: controller.warehouseState,
                  hintText: "State",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                GetBuilder<ManagerProfileController>(
                  builder: (_) => SizedBox(
                    width: double.infinity,
                    child: AttachImageWidget(
                      imgUrl: Constant.user!.manager!.storeImgUrl,
                      imgAssetPath: controller.warehouseIMG,
                      onTap: () => controller.warehouseImage(context),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Warehouse Front Picture",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    onTap: controller.profileUpdate,
                    title: "Update",
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
