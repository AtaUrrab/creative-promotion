import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/helpers/helper_class.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/cards.dart';
import '../controllers/add_controller.dart';

class OilImageScreen extends StatelessWidget {
  const OilImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Upload Images",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.logo,
                width: Get.width * 0.2,
              ),
            ],
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.black.withOpacity(0.1))
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Upload Image Before \nOil placement",
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    GetBuilder<AddController>(
                      builder: (_) {
                        return AttachImageWidget(
                          imgAssetPath: controller.beforeOilImage,
                          onTap: () async {
                            XFile? dynamicImagePath = (await HelperClass()
                                .bottomSheetImagePicker(context));
                            controller.update();
                            if (dynamicImagePath == null) {
                              return;
                            }
                            controller.beforeOilImage = dynamicImagePath.path;
                            controller.update();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 40),
                    const Text("Upload Image After \nOil placement",
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    GetBuilder<AddController>(
                      builder: (_) {
                        return AttachImageWidget(
                          imgAssetPath: controller.afterOilImage,
                          onTap: () async {
                            XFile? dynamicImagePath = (await HelperClass()
                                .bottomSheetImagePicker(context));
                            controller.update();
                            if (dynamicImagePath == null) {
                              return;
                            }
                            controller.afterOilImage = dynamicImagePath.path;
                            controller.update();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: AppButton(
              onTap: controller.gotoStoreImageScreen,
              title: "Continue",
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
