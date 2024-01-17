import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/helpers/helper_class.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/cards.dart';
import '../controllers/add_controller.dart';

class StoreImageScreen extends StatelessWidget {
  const StoreImageScreen({super.key});

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
        child: Column(
          children: [
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
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: GetBuilder<AddController>(
                    builder: (_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Upload Front Store Image",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          AttachImageWidget(
                            imgAssetPath: controller.frontStoreImage,
                            onTap: () async {
                              XFile? dynamicImagePath = (await HelperClass()
                                  .bottomSheetImagePicker(context));
                              controller.update();
                              if (dynamicImagePath == null) {
                                return;
                              }
                              controller.frontStoreImage =
                                  dynamicImagePath.path;
                              controller.update();
                            },
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            "Upload Front Door Image",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          AttachImageWidget(
                            imgAssetPath: controller.frontDoorImage,
                            onTap: () async {
                              XFile? dynamicImagePath = (await HelperClass()
                                  .bottomSheetImagePicker(context));
                              controller.update();
                              if (dynamicImagePath == null) {
                                return;
                              }
                              controller.frontDoorImage = dynamicImagePath.path;
                              controller.update();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: AppButton(
                color: AppColor.red,
                onTap: controller.gotoSignatureScreen,
                title: "Continue",
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
