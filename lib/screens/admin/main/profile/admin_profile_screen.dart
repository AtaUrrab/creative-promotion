import 'package:creativepromotion/screens/admin/main/profile/admin_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/others.dart';
import '../../../../core/widgets/textfield.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminProfileController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [
          const SizedBox(height: 20),
          GetBuilder<AdminProfileController>(
            init: AdminProfileController(),
            builder: (_) => GestureDetector(
              onTap: () => controller.onTapProfileImage(context),
              child: CircleImage(
                heading:
                    "${Constant.user!.firstName} ${Constant.user!.lastName}",
                imageUrl: Constant.user!.imgUrl,
                imgAsset: controller.profileRef,
                size: 100,
                fontSize: 26,
                isEditScreen: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(Constant.user!.email),
          const SizedBox(height: 15),
          TextFieldWidget(
            controller: controller.firstName,
            hintText: "First Name",
          ),
          const SizedBox(height: 10),
          TextFieldWidget(
            controller: controller.lastName,
            hintText: "Last Name",
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: Get.width,
            child: AppButton(
              onTap: () => controller.updateProfile(),
              title: "Update",
              color: AppColor.red,
              titleStyle: const TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
