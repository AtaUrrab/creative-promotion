import 'package:creativepromotion/screens/agent/main/profile/agent_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/others.dart';
import '../../../../core/widgets/textfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController(user: Constant.user!));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: AppColor.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  GetBuilder<ProfileController>(
                    builder: (_) {
                      return CircleImage(
                        onTap: () => controller.changeImage(context),
                        imgAsset: controller.profileRef,
                        heading:
                            "${Constant.user!.firstName} ${Constant.user!.lastName}",
                        imageUrl: Constant.user!.imgUrl,
                        size: 100,
                        fontSize: 26,
                        isEditScreen: true,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(Constant.user!.email),
              const SizedBox(height: 15),
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
                controller: controller.area,
                hintText: "Area",
              ),
              const SizedBox(height: 18),
              TextFieldWidget(
                controller: controller.phone,
                hintText: "Phone",
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  onTap: controller.submit,
                  title: "Submit",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
